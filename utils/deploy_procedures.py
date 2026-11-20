#######################################################################

import logging
import re
from pathlib import Path

from sqlalchemy.engine import Engine

logger: logging.Logger = logging.getLogger(__name__)
PROJECT_ROOT: Path = Path(__file__).resolve().parent.parent
PROCEDURE_DIRS: list[Path] = [PROJECT_ROOT / 'sql' / 'meta', PROJECT_ROOT / 'sql' / 'dw']
GO_LINE: re.Pattern[str] = re.compile(r'^[ \t]*GO[ \t]*\r?$', re.IGNORECASE | re.MULTILINE)

#######################################################################

def _get_procedure_files() -> list[Path]:
    '''
    Description:
        Lists all procedure files to deploy, in deployment order.

    Flow:
        1. Collect *.sql in sql/meta, sorted alphabetically.
        2. Collect *.sql in sql/dw, sorted alphabetically.

    Args:
        None.

    Returns:
        list[Path]: Procedure files, meta before dw.

    Raises:
        None.
    '''

    files: list[Path] = []
    for directory in PROCEDURE_DIRS:
        files.extend(sorted(directory.glob('*.sql')))
    return files

def _split_batches(path: Path) -> list[str]:
    '''
    Description:
        Reads a procedure file and splits it into batches at GO lines.

    Flow:
        1. Read the file as UTF-8, keeping its line endings.
        2. Split at lines consisting only of GO (case-insensitive,
           surrounding whitespace allowed).
        3. Drop batches that are empty or whitespace only.

    Args:
        path (Path): Full path to the procedure file.

    Returns:
        list[str]: Batches to send to the database, in file order.

    Raises:
        UnicodeDecodeError: If the file is not valid UTF-8.
    '''

    content: str = path.read_bytes().decode('utf-8')
    return [batch for batch in GO_LINE.split(content) if batch.strip()]

def deploy_procedures(engine: Engine) -> int:
    '''
    Description:
        Deploys all stored procedures from sql/meta and sql/dw in a single
        transaction. Table definitions in sql/tables are not deployed.

    Flow:
        1. List procedure files — meta before dw, alphabetical within each.
        2. Open one transaction.
        3. For each file, split into batches and execute each batch with
           exec_driver_sql — text() would treat ':' as a bind parameter.
        4. On failure, log the file and error and re-raise; the transaction
           is rolled back and no procedure is changed.
        5. Log and return the number of files deployed.

    Args:
        engine (Engine): SQLAlchemy engine connected to Skolekube.

    Returns:
        int: Number of procedure files deployed.

    Raises:
        UnicodeDecodeError: If a procedure file is not valid UTF-8.
        SQLAlchemyError: If any batch fails to execute.
    '''

    files: list[Path] = _get_procedure_files()
    logger.info('Deploying %d procedure files', len(files))
    with engine.begin() as conn:
        for path in files:
            relative_path: Path = path.relative_to(PROJECT_ROOT)
            try:
                for batch in _split_batches(path):
                    conn.exec_driver_sql(batch)
            except Exception as e:
                logger.error('Failed to deploy %s: %s', relative_path.as_posix(), e)
                raise
    logger.info('Deployed %d procedures', len(files))
    return len(files)
