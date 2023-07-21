import 'dart:io';

List<Map> accounts = [
  {"Id": 0, "Name": "admin", "Pin": 0000, "Balance": 10}, //Default data
  {"Id": 1, "Name": "User", "Pin": 2244, "Balance": 202020} //Default data
];
List Ledger = [];

void main() {
  print("====== Welcome to the Transaction Management System ======");

  showATMMenu(); // Call the menu function
}

void showATMMenu() {
  bool authorized = false;
  String name;
  int pin;

  while (!authorized) {
    print("Enter your Name: ");
    name = stdin.readLineSync() ?? 'null';

    print("Enter your 4-digit PIN: ");
    pin = int.parse(stdin.readLineSync() ?? '0');

    authorized = authorization(name, pin);

    while (authorized) {
      if (getIdWithName(name) == 0) {
        print("\n====== ATM Menu ======");
        print("1. Create Account");
        print("2. Check Balance");
        print("3. Deposit Balance");
        print("4. Withdraw Balance");
        print("5. Delete Account");
        print("6. Show Ledger");
        print("7. Exit");

        print("\nEnter your choice:");
        int choice = int.parse(stdin.readLineSync() ?? '0');

        switch (choice) {
          case 1:
            String result = createAccount();
            print("\n $result");
            break;

          case 2:
            int accountId = getIdWithName(name);
            int balance = Check_Balance(accountId);
            print("\nCurrent balance: $balance");
            break;

          case 3:
            int accountId = getIdWithName(name);
            print("\nEnter the amount to deposit:");
            int amount = int.parse(stdin.readLineSync() ?? '0');
            String result = Deposit(accountId, amount);
            print("\n $result");
            break;

          case 4:
            int accountId = getIdWithName(name);
            print("\nEnter the amount to withdraw:");
            int amount = int.parse(stdin.readLineSync() ?? '0');
            String result = Widthdraw(accountId, amount);
            print("\n $result");
            break;

          case 5:
            print("\nEnter the account ID to delete:");
            int accountId = int.parse(stdin.readLineSync() ?? '0');
            String result = deleteAccount(accountId);
            print("\n $result");
            break;
          
          case 6:
            print("\n =====Ledger======");

            String data = GetLedger();
            print(data);

            break;

          case 7:
            authorized = false;
            print(
                "\nThank you for using the Transaction Management System Of Mustafa & Haseeb");
            break;

          default:
            print("\nInvalid choice. Please try again. ");
            break;
        }
      }
      else {
        print("\n====== ATM Menu ======");
        print("1. Check Balance");
        print("2. Deposit Balance");
        print("3. Withdraw Balance");
        print("4. Exit");

        print("\nEnter your choice:");
        int choice = int.parse(stdin.readLineSync() ?? '0');

        switch (choice) {

          case 1:
            int accountId = getIdWithName(name);
            int balance = Check_Balance(accountId);
            print("\nCurrent balance: $balance");
            break;

          case 2:
            int accountId = getIdWithName(name);
            print("\nEnter the amount to deposit:");
            int amount = int.parse(stdin.readLineSync() ?? '0');
            String result = Deposit(accountId, amount);
            print("\n $result");
            break;

          case 3:
            int accountId = getIdWithName(name);
            print("\nEnter the amount to withdraw:");
            int amount = int.parse(stdin.readLineSync() ?? '0');
            String result = Widthdraw(accountId, amount);
            print("\n $result");
            break;

          case 4:
            authorized = false;
            print(
                "\nThank you for using the Transaction Management System Of Mustafa & Haseeb");
            break;

          default:
            print("\nInvalid choice. Please try again. ");
            break;
        }
      }
    }
  }
}

int Check_Balance(int Id) {
  int Balance = 0;

  final userAccountTemp = accounts.where((account) => account["Id"] == Id);
  userAccountTemp.forEach((element) {
    Balance = element["Balance"];
  });
  return (Balance);
}

String Widthdraw(int Id, int Amount) {
  int Balance = 0;

  final userAccountTemp = accounts.where((account) => account["Id"] == Id);
  userAccountTemp.forEach((element) {
    Balance = element["Balance"];
  });

  if (Amount > Balance) {
    return ("\nCurrent balance is insufficient for this transaction.");
  } else {
    int Index = accounts.indexWhere((element) => element["Id"] == Id);

    int Balance_Old = Balance;
    Balance = Balance - Amount;

    Ledger.add({
      "Id": Id,
      "Name": accounts[Index]["Name"],
      "Old_Balance": Balance_Old,
      "Transaction Ammount": (0 - Amount),
      "Current_Balance": Balance,
      "Date": DateTime.now()
    });

    accounts[Index]["Balance"] = Balance;

    return ("Transaction completed succesfully");
  }
}

String Deposit(int Id, int Amount) {
  int Balance = 0;

  final userAccountTemp = accounts.where((account) => account["Id"] == Id);
  userAccountTemp.forEach((element) {
    Balance = element["Balance"];
  });

  int Index = accounts.indexWhere((element) => element["Id"] == Id);

  int Balance_Old = Balance;
  Balance = Balance + Amount;

  Ledger.add({
    "Id": Id,
    "Name": accounts[Index]["Name"],
    "Old_Balance": Balance_Old,
    "Transaction Ammount": (0 + Amount),
    "Current_Balance": Balance,
    "Date": DateTime.now()
  });

  accounts[Index]["Balance"] = Balance;

  return ("Transaction completed succesfully, Your Balance is: $Balance");
}

String createAccount() {
  String? name;
  int? pin;
  int Id = accounts.length;

  while (name == null) {
    print("Enter Name:");
    name = stdin.readLineSync();
  }
  while (pin == null || pin < 4) {
    print("Enter a PIN that is lonnger than Four digits");
    pin = int.parse(stdin.readLineSync() ?? '0');
  }

  accounts.add({"Id": Id, "Name": name, "Pin": pin, "Balance": 0});

  return ("\nAccount created succesfully");
}

String deleteAccount(int Id) {
  accounts.removeWhere((element) => element["Id"] == Id);

  return ("Account deleted succesfully");
}

int getIdWithName(String name) {
  int Index = accounts.indexWhere((element) => element["Name"] == name);
  int Id = accounts[Index]["Id"];

  return Id;
}

bool authorization(String name, int pin) {
  final accountsTemp = accounts.where((element) => element["Name"] == name);

  if (accountsTemp.length <= 0) {
    print("\nName not found! \n");

    return false;
  }

  int Index = accounts.indexWhere((element) => element["Name"] == name);

  if (accounts[Index]["Pin"] != pin) {
    print("\nPin invalid! \n");

    return false;
  }
  return true;
}

String GetLedger(){

  String Output = '';

  for (var record in Ledger) {

    Output = Output + "\n User Id: ${record['Id']}, Name: ${record['Name']}, Prevours Balance: ${record['Old_Balance']}, Transaction: ${record['Transaction Ammount']}, Current Balance: ${record['Current_Balance']}, Date: ${record['Date']}";
  }

  return Output;
}
