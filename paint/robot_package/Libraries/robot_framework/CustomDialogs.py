from robot.api.deco import keyword
from robot.libraries.Dialogs import get_value_from_user
from robot.libraries.dialogs_py import _TkDialog
from robot.version import get_version
import logging

__version__ = get_version()
__all__ = ['ask_yes_or_no_question', 'get_value_from_user']

@keyword
def ask_yes_or_no_question(message):
    """Pauses execution until the user confirms a choice in a dialog.

    This keyword displays a dialog with an instruction `message`. The user can interact
    with the dialog by clicking either the "YES" or "NO" button. If "YES" is clicked,
    the keyword returns `True`, and if "NO" is clicked, it returns `False`.

    Args:
        message (str): The instruction shown in the dialog.

    Returns:
        bool: The user's choice. `True` if "YES" is clicked, `False` if "NO" is clicked.
    """
    result = _validate_user_input(PassFailDialog2(message))
    logging.info(f"Dialog result: {result}")
    return result


def _validate_user_input(dialog):
    """Validates the user's input from the dialog.

        This function handles the user's input from the dialog by showing the dialog and
        logging the value chosen by the user. If no value is provided (e.g., dialog closed),
        it raises a RuntimeError.

        Args:
            dialog (PassFailDialog2): The dialog instance to show.

        Returns:
            bool: The user's choice from the dialog.
        """
    value = dialog.show()
    logging.info(f"Dialog value: {value}")
    if value is None:
        raise RuntimeError('No value provided by user.')
    return value


class PassFailDialog2(_TkDialog):
    """Custom dialog for "YES" and "NO" choice.

       This dialog inherits from _TkDialog and provides options for the user to choose
       between "YES" and "NO". It handles the actions when each button is clicked.

       Attributes:
           _left_button (str): The label for the "YES" button.
           _right_button (str): The label for the "NO" button.
       """
    _left_button = 'YES'
    _right_button = 'NO'

    def _get_value(self):
        logging.info("YES button clicked")
        return True

    def _get_right_button_value(self):
        logging.info("NO button clicked")
        return False


# Ensure logging is configured to output to console
logging.basicConfig(level=logging.INFO)