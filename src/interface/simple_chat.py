import sys
import os
import json
from datetime import datetime
from pathlib import Path
import random

class SimpleChat:
    def __init__(self):
        self.chat_history = []
        self.ensure_directories()
        self.load_responses()

    def ensure_directories(self):
        """Create necessary directories"""
        for directory in ["logs", "chats", "models"]:
            Path(directory).mkdir(exist_ok=True)

    def load_responses(self):
        """Load predefined responses"""
        self.responses = {
            'greeting': [
                "Hei! Hvordan kan jeg hjelpe deg i dag?",
                "God dag! Hva kan jeg gjøre for deg?",
                "Hei der! Hyggelig å snakke med deg!",
                "Heisann! Jeg er her for å hjelpe!"
            ],
            'question': [
                "La meg tenke på det... ",
                "Det er et interessant spørsmål. ",
                "La meg prøve å hjelpe deg med det. ",
                "Jeg skal gjøre mitt beste for å svare. "
            ],
            'thanks': [
                "Bare hyggelig! Er det noe annet jeg kan hjelpe med?",
                "Det var så lite! Spør gjerne hvis du lurer på noe mer.",
                "Ingen årsak! Jeg er her hvis du trenger mer hjelp.",
                "Det var en fornøyelse å hjelpe!"
            ],
            'unknown': [
                "Fortell meg mer om det du tenker på.",
                "Interessant! Kan du utdype det?",
                "Jeg vil gjerne høre mer om dette.",
                "Kan du forklare det på en annen måte?"
            ],
            'help': [
                """
Tilgjengelige kommandoer:
- 'hjelp' : Viser denne hjelpeteksten
- 'exit' : Avslutter chatten
- 'status' : Viser AI agent status
- 'clear' : Tømmer skjermen
                """,
            ]
        }

    def save_chat(self):
        """Save chat history"""
        if not self.chat_history:
            return

        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        filename = f"chats/chat_{timestamp}.json"

        with open(filename, "w", encoding="utf-8") as f:
            json.dump({
                "timestamp": datetime.now().isoformat(),
                "messages": self.chat_history
            }, f, ensure_ascii=False, indent=2)

        print(f"\nChat lagret til: {filename}")

    def start_chat(self):
        """Start the chat interface"""
        print("="*50)
        print("Velkommen til Quantum AI Agent Chat")
        print("Skriv 'hjelp' for å se kommandoer")
        print("Skriv 'exit' for å avslutte")
        print("="*50)
        print()

        # Send welcome message
        print("AI > " + random.choice(self.responses['greeting']) + "\n")

        while True:
            try:
                user_input = input("Du > ").strip()

                if user_input.lower() == 'exit':
                    break

                if user_input.lower() == 'clear':
                    os.system('cls' if os.name == 'nt' else 'clear')
                    continue

                # Add user message to history
                self.chat_history.append({
                    "role": "user",
                    "message": user_input,
                    "timestamp": datetime.now().isoformat()
                })

                # Generate response
                response = self.generate_response(user_input)

                # Add AI response to history
                self.chat_history.append({
                    "role": "ai",
                    "message": response,
                    "timestamp": datetime.now().isoformat()
                })

                print(f"AI > {response}\n")

            except KeyboardInterrupt:
                break
            except Exception as e:
                print(f"Error: {e}")

        # Save chat before exiting
        self.save_chat()
        print("\nTakk for praten! Ha en fin dag!")

    def generate_response(self, user_input: str) -> str:
        """Generate a response to user input"""
        user_input = user_input.lower()

        # Check for help command
        if user_input in ['hjelp', 'help']:
            return self.responses['help'][0]

        # Check for greetings
        if any(word in user_input for word in ['hei', 'hello', 'god dag', 'heisann', 'hallo']):
            return random.choice(self.responses['greeting'])

        # Check for questions
        if any(word in user_input for word in ['hvordan', 'hva', 'hvilken', 'hvor', 'hvem', 'hvorfor', '?']):
            base_response = random.choice(self.responses['question'])
            if 'weather' in user_input or 'vær' in user_input:
                return base_response + "Jeg kan dessverre ikke sjekke været akkurat nå."
            if 'navn' in user_input:
                return base_response + "Jeg er Quantum AI Agent, din AI-assistent."
            return base_response + "Kan du være mer spesifikk?"

        # Check for thanks
        if any(word in user_input for word in ['takk', 'thanks', 'tusen takk']):
            return random.choice(self.responses['thanks'])

        # Default response
        return random.choice(self.responses['unknown'])

def main():
    chat = SimpleChat()
    chat.start_chat()

if __name__ == "__main__":
    main()