import os
import codecs

folder_path = './res/smartcontracts'
output_folder_path = './res/output'

def custom_operation(content):
    print(content)
    return "some random content"

sol_files = [f for f in os.listdir(folder_path) if f.endswith('.sol')]

for file_name in sol_files:
    file_path = os.path.join(folder_path, file_name)

    with codecs.open(file_path, 'r', encoding='utf-8') as file:
        file_content = file.read()

    result = custom_operation(file_content)

    # Tworzenie nazwy pliku wyjściowego
    output_file_name = file_name.replace('.sol', '_output.txt')
    output_file_path = os.path.join(output_folder_path, output_file_name)

    # Zapis wyniku do pliku wyjściowego
    with codecs.open(output_file_path, 'w', encoding='utf-8') as output_file:
        output_file.write(result)