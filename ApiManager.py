# cohere imports
import cohere
# lama imports
import json
from llamaapi import LlamaAPI
# textcortext
import requests

class APIManagerZad1:
    cohere_api_key = 'nasXJmj9GyZF0hH7LsS3CwXoVqrEqc4QlolOAM7B'
    llama_api_key = 'LL-4Upqf2Vo34LciTSHPNG44yNuByGyvoxXATFaZ5CaktJWp42OgkHcO4VQROLP2LLT'

    @staticmethod
    def cohere_api(smartcontract_content, test_result):
        body = APIManagerZad3._generate_api_content(smartcontract_content, test_result)
        response = cohere.Client(APIManagerZad3.cohere_api_key).chat(body, model="command", temperature=0.9)
        answer = response.text
        print(answer)
        return answer

    @staticmethod
    def llama_api(smartcontract_content, test_result):
        content = APIManagerZad3._generate_api_content(smartcontract_content, test_result)
        api_request_json = {
            "messages": [{"role": "user", "content": content}],
            "stream": False,
        }
        response = LlamaAPI(APIManagerZad3.llama_api_key).run(api_request_json)
        choices = response.json()["choices"]
        for choice in choices:
            message = choice.get("message", {})
            content = message.get("content")

            if content:
                print(f"\n{'-' * 20}\n", content, end=f"\n{'-' * 20}\n")
                return content
            else:
                print("Brak odpowiedzi tekstowej od \"Lama\"")
                return "Brak odpowiedzi tekstowej od \"Lama\""
        return "Coś poszło nie tak..."

    @staticmethod
    def textcortext_api(smartcontract_content, test_result):
        content = APIManagerZad3._generate_api_content(smartcontract_content, test_result)
        url = "https://api.textcortex.com/v1/codes"
        headers = {
            "Authorization": "Bearer gAAAAABlfG5BBC3rNLSjTFfpjwo293OPUgfJDm_w-v6vF2f64wOjel5KF3vW5scXN-Pt5hCLQNFpCCMWEyoJNIOb_dY5PGWDpkHXAx4eM61eUb6Z6NEtbdSK3uAYt-70TzjdpUjJW9yh"
        }
        data = {
            "max_tokens": 512,
            "mode": "python",
            "model": "icortex-1",
            "n": 1,
            "temperature": 0,
            "text": content
        }

        response = requests.post(url, headers=headers, json=data)

        if response.status_code == 200:
            parsed_response = response.json()
            outputs = parsed_response.get('data', {}).get('outputs', [])
            if outputs:
                text_output = outputs[0].get('text')
                print("Odpowiedź textcortext: ", text_output)
                return text_output
            else:
                print("Brak danych tekstowych w odpowiedzi API.")
                return None
        else:
            print("Błąd w żądaniu:", response.status_code)
            return "Błąd podczas otrzymywania odpowiedzi czatu \"textcortext\""

    @staticmethod
    def _generate_api_content(smartcontract_content, test_result):
        return f"Rozmowa będzie prowadzona w języku polskim. Mając ten smartkontrakt: `{smartcontract_content}`, oraz ten wynik testów tego smartkontraktu: `{test_result}`, zaproponuj poprawiony smartkontrakt."


class APIManagerZad2:
    cohere_api_key = 'nasXJmj9GyZF0hH7LsS3CwXoVqrEqc4QlolOAM7B'
    llama_api_key = 'LL-4Upqf2Vo34LciTSHPNG44yNuByGyvoxXATFaZ5CaktJWp42OgkHcO4VQROLP2LLT'

    @staticmethod
    def cohere_api(smartcontract_content, test_result):
        body = APIManagerZad3._generate_api_content(smartcontract_content, test_result)
        response = cohere.Client(APIManagerZad3.cohere_api_key).chat(body, model="command", temperature=0.9)
        answer = response.text
        print(answer)
        return answer

    @staticmethod
    def llama_api(smartcontract_content, test_result):
        content = APIManagerZad3._generate_api_content(smartcontract_content, test_result)
        api_request_json = {
            "messages": [{"role": "user", "content": content}],
            "stream": False,
        }
        response = LlamaAPI(APIManagerZad3.llama_api_key).run(api_request_json)
        choices = response.json()["choices"]
        for choice in choices:
            message = choice.get("message", {})
            content = message.get("content")

            if content:
                print(f"\n{'-' * 20}\n", content, end=f"\n{'-' * 20}\n")
                return content
            else:
                print("Brak odpowiedzi tekstowej od \"Lama\"")
                return "Brak odpowiedzi tekstowej od \"Lama\""
        return "Coś poszło nie tak..."

    @staticmethod
    def textcortext_api(smartcontract_content, test_result):
        content = APIManagerZad3._generate_api_content(smartcontract_content, test_result)
        url = "https://api.textcortex.com/v1/codes"
        headers = {
            "Authorization": "Bearer gAAAAABlfG5BBC3rNLSjTFfpjwo293OPUgfJDm_w-v6vF2f64wOjel5KF3vW5scXN-Pt5hCLQNFpCCMWEyoJNIOb_dY5PGWDpkHXAx4eM61eUb6Z6NEtbdSK3uAYt-70TzjdpUjJW9yh"
        }
        data = {
            "max_tokens": 512,
            "mode": "python",
            "model": "icortex-1",
            "n": 1,
            "temperature": 0,
            "text": content
        }

        response = requests.post(url, headers=headers, json=data)

        if response.status_code == 200:
            parsed_response = response.json()
            outputs = parsed_response.get('data', {}).get('outputs', [])
            if outputs:
                text_output = outputs[0].get('text')
                print("Odpowiedź textcortext: ", text_output)
                return text_output
            else:
                print("Brak danych tekstowych w odpowiedzi API.")
                return None
        else:
            print("Błąd w żądaniu:", response.status_code)
            return "Błąd podczas otrzymywania odpowiedzi czatu \"textcortext\""

    @staticmethod
    def _generate_api_content(smartcontract_content, test_result):
        return f"Rozmowa będzie prowadzona w języku polskim. Mając ten smartkontrakt: `{smartcontract_content}`, oraz ten wynik testów tego smartkontraktu: `{test_result}`, zaproponuj poprawiony smartkontrakt."


class APIManagerZad3:
    cohere_api_key = 'nasXJmj9GyZF0hH7LsS3CwXoVqrEqc4QlolOAM7B'
    llama_api_key = 'LL-4Upqf2Vo34LciTSHPNG44yNuByGyvoxXATFaZ5CaktJWp42OgkHcO4VQROLP2LLT'

    @staticmethod
    def cohere_api(smartcontract_content, test_result):
        body = APIManagerZad3._generate_api_content(smartcontract_content, test_result)
        response = cohere.Client(APIManagerZad3.cohere_api_key).chat(body, model="command", temperature=0.9)
        answer = response.text
        print(answer)
        return answer

    @staticmethod
    def llama_api(smartcontract_content, test_result):
        content = APIManagerZad3._generate_api_content(smartcontract_content, test_result)
        api_request_json = {
            "messages": [{"role": "user", "content": content}],
            "stream": False,
        }
        response = LlamaAPI(APIManagerZad3.llama_api_key).run(api_request_json)
        choices = response.json()["choices"]
        for choice in choices:
            message = choice.get("message", {})
            content = message.get("content")

            if content:
                print(f"\n{'-' * 20}\n", content, end=f"\n{'-' * 20}\n")
                return content
            else:
                print("Brak odpowiedzi tekstowej od \"Lama\"")
                return "Brak odpowiedzi tekstowej od \"Lama\""
        return "Coś poszło nie tak..."

    @staticmethod
    def textcortext_api(smartcontract_content, test_result):
        content = APIManagerZad3._generate_api_content(smartcontract_content, test_result)
        url = "https://api.textcortex.com/v1/codes"
        headers = {
            "Authorization": "Bearer gAAAAABlfG5BBC3rNLSjTFfpjwo293OPUgfJDm_w-v6vF2f64wOjel5KF3vW5scXN-Pt5hCLQNFpCCMWEyoJNIOb_dY5PGWDpkHXAx4eM61eUb6Z6NEtbdSK3uAYt-70TzjdpUjJW9yh"
        }
        data = {
            "max_tokens": 512,
            "mode": "python",
            "model": "icortex-1",
            "n": 1,
            "temperature": 0,
            "text": content
        }

        response = requests.post(url, headers=headers, json=data)

        if response.status_code == 200:
            parsed_response = response.json()
            outputs = parsed_response.get('data', {}).get('outputs', [])
            if outputs:
                text_output = outputs[0].get('text')
                print("Odpowiedź textcortext: ", text_output)
                return text_output
            else:
                print("Brak danych tekstowych w odpowiedzi API.")
                return None
        else:
            print("Błąd w żądaniu:", response.status_code)
            return "Błąd podczas otrzymywania odpowiedzi czatu \"textcortext\""

    @staticmethod
    def _generate_api_content(smartcontract_content, test_result):
        return f"Rozmowa będzie prowadzona w języku polskim. Mając ten smartkontrakt: `{smartcontract_content}`, oraz ten wynik testów tego smartkontraktu: `{test_result}`, zaproponuj poprawiony smartkontrakt."
