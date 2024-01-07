#include <iostream>
#include <fstream>
#include <string>
#include <cctype>
#include <algorithm>
#include <cstddef>
/*
Made By : Bilal Qadeer (22-CP-30)
          Abdul Rehman (22-CP-54)
          Habib Ullah  (22-CP-62)
          Huzaifa Asif (22-CP-52)
*/
using namespace std;

class Node {
public:
    string name;
    string phone_number;
    Node* next;

    Node(string name, string phone_number) {
        this->name = name;
        this->phone_number = phone_number;
        this->next = nullptr;
    }
};

class PhoneDirectory {
public:
    Node* head;

    PhoneDirectory() {
        head = nullptr;
    }

    void addContact(string name, string phone_number) {
        if (isDigitsOnly(phone_number)) {
            Node* newNode = new Node(name, phone_number);
            newNode->next = head;
            head = newNode;
        } else {
            cout << "Invalid Phone Number. Please enter an 11-digit number.\n";
        }
    }

    bool removeContact(string name) {
        Node* current = head;
        Node* previous = nullptr;

        while (current != nullptr && current->name != name) {
            previous = current;
            current = current->next;
        }

        if (current == nullptr) {
            return false; // Contact not found
        }

        if (previous == nullptr) {
            head = current->next;
        } else {
            previous->next = current->next;
        }

        delete current;
        return true;
    }

    void showContacts(string sortBy = "name", bool ascending = true) {
        if (head == nullptr) {
            cout << "No contacts in the directory." << endl;
            return;
        }

        if (sortBy == "name") {
            _showContactsSortedByName(ascending);
        } else if (sortBy == "phone") {
            _showContactsSortedByPhone(ascending);
        } else {
            cout << "Invalid sorting option." << endl;
        }
    }

    void saveContactsToFile() {
        ofstream file("contacts.txt");
        if (file.is_open()) {
            Node* current = head;
            while (current != nullptr) {
                file << current->name << " " << current->phone_number << endl;
                current = current->next;
            }
            file.close();
            cout << "Contacts saved to 'contacts.txt'." << endl;
        } else {
            cout << "Error opening file for writing." << endl;
        }
    }

    void loadContactsFromFile() {
        ifstream file("contacts.txt");
        if (file.is_open()) {
            string name, phone;
            while (file >> name >> phone) {
                addContact(name, phone);
            }
            file.close();
            cout << "Contacts loaded from 'contacts.txt'." << endl;
        } else {
            cout << "No existing contacts file found." << endl;
        }
    }

    Node* searchContact(const string& key) {
        Node* current = head;
        while (current != nullptr) {
            if (current->name == key || current->phone_number == key) {
                return current; // Contact found
            }
            current = current->next;
        }
        return nullptr; // Contact not found
    }

private:
    void _showContactsSortedByName(bool ascending) {
        Node* current = head;
        vector<Node*> contacts;

        while (current != nullptr) {
            contacts.push_back(current);
            current = current->next;
        }

        if (ascending) {
            sort(contacts.begin(), contacts.end(), [](const Node* a, const Node* b) {
                return a->name < b->name;
            });
        } else {
            sort(contacts.begin(), contacts.end(), [](const Node* a, const Node* b) {
                return a->name > b->name;
            });
        }

        for (const auto& contact : contacts) {
            cout << contact->name << ": " << contact->phone_number << endl;
        }
    }

    void _showContactsSortedByPhone(bool ascending) {
        Node* current = head;
        vector<Node*> contacts;

        while (current != nullptr) {
            contacts.push_back(current);
            current = current->next;
        }

        if (ascending) {
            sort(contacts.begin(), contacts.end(), [](const Node* a, const Node* b) {
                return a->phone_number < b->phone_number;
            });
        } else {
            sort(contacts.begin(), contacts.end(), [](const Node* a, const Node* b) {
                return a->phone_number > b->phone_number;
            });
        }

        for (const auto& contact : contacts) {
            cout << contact->name << ": " << contact->phone_number << endl;
        }
    }

    bool isDigitsOnly(const string& str) {
        return all_of(str.begin(), str.end(), ::isdigit);
    }
};

int main() {
    PhoneDirectory directory;
    directory.loadContactsFromFile();

    while (true) {
        cout << "*******************************{ Phone Directory }******************************";
        cout << "\nMenu:\n1. Add Contact\n2. Remove Contact\n3. Show Contacts\n4. Search Contact\n5. Save Contacts\n6. Info\n7. Exit\n";
        cout << "Enter your choice (1-7): ";
        int choice;
        cin >> choice;

        switch (choice) {
            case 1: {
                string name, phone;
                cout << "Enter contact name: ";
                cin >> name;
                do {
                    cout << "Enter contact phone number: ";
                    cin >> phone;
                    if (phone.length() != 11)
                        cout << "Invalid Phone Number. Please enter an 11-digit number.";
                } while (phone.length() != 11);
                directory.addContact(name, phone);
                break;
            }
            case 2: {
                string name;
                cout << "Enter the name of the contact to remove: ";
                cin >> name;
                if (directory.removeContact(name)) {
                    cout << "Contact removed successfully." << endl;
                } else {
                    cout << "Contact not found." << endl;
                }
                break;
            }
            case 3: {
                cout << "\nSorting Options:\n1. Sort by Name\n2. Sort by Phone Number\n";
                int sortChoice;
                cin >> sortChoice;

                bool ascending;
                cout << "Sort in ascending order? (1 for yes, 0 for no): ";
                cin >> ascending;

                if (sortChoice == 1) {
                    directory.showContacts("name", ascending);
                } else if (sortChoice == 2) {
                    directory.showContacts("phone", ascending);
                } else {
                    cout << "Invalid sorting option." << endl;
                }
                break;
            }
            case 4: {
                string key;
                cout << "Enter name or phone number to search: ";
                cin >> key;
                Node* result = directory.searchContact(key);
                if (result) {
                    cout << "Contact found: " << result->name << ": " << result->phone_number << endl;
                } else {
                    cout << "Contact not found." << endl;
                }
                break;
            }
            case 5: {
                directory.saveContactsToFile();
                break;
            }
            case 6: {
            	cout<<"Project Name : Phone Directory Management System\n";
            	cout<<"Made By : Bilal Qadeer (22-CP-30)\n";
          		cout<<"          Abdul Rehman (22-CP-54)\n";
          		cout<<"          Habib Ullah  (22-CP-62)\n";
          		cout<<"          Huzaifa Asif (22-CP-52)\n";
          		cout<<"Submitted To : Dr. Rizwan\n";
          		cout<<"Date : 29-12-2023\n";
				break;
			}
            case 7: {
                directory.saveContactsToFile();
                cout << "Exiting the program." << endl;
                return 0;
            }
            default: {
                cout << "Invalid choice. Try again." << endl;
            }
        }
    }

    return 0;
}


