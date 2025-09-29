import os
import shutil
import subprocess
import time
from robot.libraries.BuiltIn import BuiltIn
from robot.api.deco import keyword
from PIL import Image
import logging
from datetime import datetime

import pytesseract

pytesseract.pytesseract.tesseract_cmd = r'C:\Program Files\Tesseract-OCR\tesseract.exe'

def reverse_byte(n):
    """
    This is to reverse the byte between MSB and LSB
    :param n: the int byte to be reversed
    :return: the reversed byte
    """
    rev = 0
    for i in range(8):
        rev = rev << 1
        if n & 1 == 1:
            rev = rev ^ 1
        n = n >> 1
    return rev


def print_list_to_txt_file(txt_file_path, list_to_print):
    """
    Printing list in a text file
    :param txt_file_path: The text file location to save to
    :param list_to_print: the list you want to print
    """
    with open(txt_file_path, 'w') as file:
        for item in list_to_print:
            file.write("%s\n" % item)


def read_list_from_txt_file(txt_file_path):
    """
    Reading a text file into a list
    :param txt_file_path: File path you want to read from
    :return: The list of data in the .txt file
    """
    data_list = []
    with open(txt_file_path, encoding='utf-8') as file:
        for line in file:
            data_list.append(line[0:4])
    return data_list


def print_to_txt_file(txt_file_path, text):
    """
    Prints text to a text file
    :param txt_file_path: The text file location to save to
    :param text: the text you want to print
    """
    if not os.path.exists(txt_file_path):
        return -1
    with open(txt_file_path, 'w') as file:
        file.write(str(text))


def read_from_txt_file(txt_file_path):
    """
        Reads a text file
        :param txt_file_path: File path you want to read from
        :return: The text in the .txt file
    """
    if not os.path.exists(txt_file_path):
        return -1
    with open(txt_file_path, encoding='utf-8') as file:
        text = file.read()
    return text


def clear_bin_file(file_path):
    open(file_path, 'wb').close()


def clear_txt_file(file_path):
    open(file_path, 'w').close()


def bin_to_txt(bin_file_path, txt_file_path):
    """
    Dumps the content of a bin file into a txt file
    """
    with open(bin_file_path,
              'rb') as bin_file:
        with open(txt_file_path,
                  'a') as txt_file:
            while True:
                hexdata = bin_file.read(1).hex()
                if len(hexdata) == 0:
                    break
                txt_file.write(("0x%02X" % int(hexdata, 16)) + '\n')


@keyword
def get_current_time():
    return time.time()


@keyword
def Calculate_timeout_time(timeout_time_sec: int):
    return time.time() + (timeout_time_sec * 1)


@keyword
def get_element_coordinates(location):
    location = str(location)
    location = location[1:len(location) - 1]
    comma_index = location.index(',')
    x = int(location[5:comma_index])
    y = int(location[comma_index + 7:len(location)])
    return x, y


@keyword
def get_element_dimensions(size):
    size = str(size)
    size = size[1:len(size) - 1]
    comma_index = size.index(',')
    height = int(size[10:comma_index])
    width = int(size[comma_index + 11:len(size)])
    return height, width


@keyword
def get_text_from_image(path):
    return pytesseract.image_to_string(path)


@keyword
def clean_chrome_caches():
    shutil.rmtree("D:\\Repos\\Automated-Testing\\apps\\crypto_guard\\resources\\app_source\\metamask\\Custom_Chrome")


@keyword
def twi_keyword_teardown_failed(*args):
    BuiltIn().set_suite_variable("${TEARDOWN_FAILED}", 1)
    BuiltIn().fail("Teardown Failed!")


@keyword
def twi_keyword_teardown_passed(*args):
    BuiltIn().set_suite_variable("${TEARDOWN_FAILED}", 0)


@keyword
def twi_keyword_test_case_setup_failed_after_teardown_fail(*args):
    BuiltIn().set_suite_variable("${TEARDOWN_FAILED}", 2)
    BuiltIn().fail("Setup Failed After Teardown Fail!")


@keyword
def run_CMD_command(command: str):
    subprocess.call([r'{}'.format(command)])


@keyword
def delete_file(file_path: str):
    os.remove(file_path)


@keyword
def check_if_file_exists(file_path: str):
    is_existing = os.path.exists(file_path)
    return is_existing


@keyword
def get_user_name():
    os.system('echo %USERNAME% > tmp')
    output = open('tmp', 'r').read()
    os.remove('tmp')
    return output


@keyword
def get_all_possible_combinations(account_types_list: list):
    possible_combinations = []
    account_types_list_size = len(account_types_list)

    for account_type in account_types_list:
        sending_account = account_type
        for i in range(account_types_list_size):

            receiving_account = account_types_list[i]
            possible_combinations.append([sending_account, receiving_account])

    # print(possible_combinations)
    return possible_combinations


@keyword
def check_text_for_space(text):
    return ' ' in text


@keyword
def get_variable_from_shared_file(file_path, variable_name):
    try:
        with open(file_path, 'r') as file:
            for line in file:
                # Remove any leading/trailing whitespace and split by '='
                line = line.strip()
                if '=' in line:
                    name, value = map(str.strip, line.split('=', 1))
                    # Check if the current variable name matches the given name
                    if name == variable_name:
                        return value
        # If the variable was not found, return None or raise an exception
        return None
    except FileNotFoundError:
        print(f"Error: The file at {file_path} was not found.")
        return None
    except Exception as e:
        print(f"An error occurred: {e}")
        return None


@keyword
def set_variable_in_shared_file(file_path, variable_name, variable_value):
    try:
        # Read the file content
        with open(file_path, 'r') as file:
            lines = file.readlines()

        variable_found = False
        # Update the variable value if it exists
        for i, line in enumerate(lines):
            line = line.strip()
            if '=' in line:
                name, value = map(str.strip, line.split('=', 1))
                if name == variable_name:
                    lines[i] = f"{variable_name} = {variable_value}\n"
                    variable_found = True
                    break

        # If the variable was not found, show an error
        if not variable_found:
            print(f"Error: Variable '{variable_name}' not found in the file.")
            return

        # Write the updated content back to the file
        with open(file_path, 'w') as file:
            file.writelines(lines)

        print(f"The value of '{variable_name}' has been set to '{variable_value}'.")

    except FileNotFoundError:
        print(f"Error: The file at {file_path} was not found.")
    except Exception as e:
        print(f"An error occurred: {e}")


@keyword
def twi_keyword_log_to_file(message, log_file, has_timestamp=True):
    # Ensure the directory exists
    log_dir = os.path.dirname(log_file)
    for i in range(5):
        if not os.path.exists(log_dir):
            os.makedirs(log_dir)
        else:
            break
        time.sleep(1)

    if has_timestamp:
        # Get the current time
        current_time = datetime.now().strftime('%Y-%m-%d %H:%M:%S')

        # Write the message to the log file
        with open(log_file, 'a') as f:
            f.write(f"{current_time} -->> {message}\n")

    else:
        # Write the message to the log file
        with open(log_file, 'a') as f:
            f.write(f"{message}\n")


def read_var_from_txt_file(txt_file_path):
    """
    Reading a text file into a variable
    :param txt_file_path: File path you want to read from
    :return: The variable in the .txt file
    """
    data_list = []
    with open(txt_file_path, encoding='utf-8') as file:
        var = file.read()

    print(f"this is the time : {var}")
    return var

@keyword
def check_specific_word_exists_in_file(file_path, txt_keyword):
    try:
        with open(file_path, 'r') as file:
            content = file.read()
            if txt_keyword in content:
                return True
            else:
                return False
    except FileNotFoundError:
        print(f"The file at {file_path} was not found.")
        return False
    except IOError:
        print(f"Error reading the file at {file_path}.")
        return False
@keyword
def get_ios_udid():
    """
    Retrieves the UDID of the first connected iOS device using 'idevice_id'.
    Return: -1 if not found
            The First UDID found `idevice_id -l`
    """
    # Run the idevice_id command to list UDIDs
    result = subprocess.check_output(["idevice_id", "-l"], text=True)
    udids = result.strip().splitlines()

    if not udids:
        print('\033[91m' + "[PYTHON SCRIPT] No iOS devices connected. Please connect a device.")
        return -1
    # Return the first UDID found
    return udids[0]
# path="/Users/testing/Desktop/Repos/529/apps/reference_design/resources/test_data/timestamp.txt"
# read_var_from_txt_file(path)
