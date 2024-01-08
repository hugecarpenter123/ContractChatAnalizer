import os
import codecs
from ApiManager import APIManagerZad1
from ApiManager import APIManagerZad2
from ApiManager import APIManagerStaticToDynamic

contracts_folder_path = './res/smartcontracts'
static_tests_results_folder_path = './res/smartcontracts_static_tests_results'
dynamic_tests_results_folder_path = './res/smartcontracts_dynamic_tests_results'

static_to_dynamic_output_folder_path = './res/output/static_to_dynamic'



def custom_operation(contract_content, static_test_result, dynamic_test_result):
    print("=" * 100)
    print(contract_content)
    print(static_test_result)
    print(dynamic_test_result)
    print("=" * 100, "\n")


sol_files = [f for f in os.listdir(contracts_folder_path) if f.endswith('.sol')]
static_tests_results_files = [f for f in os.listdir(static_tests_results_folder_path)]
dynamic_tests_results_files = [f for f in os.listdir(dynamic_tests_results_folder_path)]

for file_name in sol_files:
    contract_path = os.path.join(contracts_folder_path, file_name)
    static_test_path = os.path.join(static_tests_results_folder_path, file_name.replace('.sol', '_solhint.txt'))
    dynamic_test_path = os.path.join(dynamic_tests_results_folder_path, file_name.replace('.sol', '_manticore.txt'))

    if os.path.isfile(static_test_path) and os.path.isfile(dynamic_test_path):
        with codecs.open(contract_path, 'r', encoding='utf-8') as contract_file, \
                codecs.open(static_test_path, 'r', encoding='utf-8') as static_test_file, \
                codecs.open(dynamic_test_path, 'r', encoding='utf-8') as dynamic_test_file:
            contract_content = contract_file.read()
            static_test_result = static_test_file.read()
            dynamic_test_result = dynamic_test_file.read()

            lama_result = APIManagerStaticToDynamic.llama_api(contract_content, static_test_result)
            cohere_result = APIManagerStaticToDynamic.cohere_api(contract_content,
                                                                 static_test_result)
            textcortext_result = APIManagerStaticToDynamic.textcortext_api(contract_content,
                                                                           static_test_result)

            # Tworzenie nazwy pliku wyjściowego
            lama_output_file_name = file_name.replace('.sol', '_lama.txt')
            lama_output_file_path = os.path.join(static_to_dynamic_output_folder_path, lama_output_file_name)

            cohere_output_file_name = file_name.replace('.sol', '_cohere.txt')
            cohere_output_file_path = os.path.join(static_to_dynamic_output_folder_path, cohere_output_file_name)

            textCortext_output_file_name = file_name.replace('.sol', '_textcortext.txt')
            textCortext_output_file_path = os.path.join(static_to_dynamic_output_folder_path, textCortext_output_file_name)

            # Zapis wyniku do pliku wyjściowego
            with codecs.open(lama_output_file_path, 'w', encoding='utf-8') as lama_output_file, \
                    codecs.open(cohere_output_file_path, 'w', encoding='utf-8') as cohere_output_file, \
                    codecs.open(textCortext_output_file_path, 'w', encoding='utf-8') as textCortext_output_file:

                lama_output_file.write(lama_result)
                cohere_output_file.write(cohere_result)
                textCortext_output_file.write(textcortext_result)
