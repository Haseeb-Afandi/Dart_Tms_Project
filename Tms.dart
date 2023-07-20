import 'dart:io';

List<Map> accounts = [
  {"Id": 0, "Name": "admin", "Pin": 0000, "Balance": 10}
];
List Ledger = [];

void main() {
  print("======Welcome to the Transaction Management System======");

  bool auth = false;
  bool exit = false;
  int userId;
  int Input = 0;
  String name = 'null';

  while (!auth) {
    print("Enter your Name: ");
    name = stdin.readLineSync() ?? 'null';

    print("Enter your 4-digit PIN: ");
    int pin = int.parse(stdin.readLineSync() ?? '0');

    auth = authorization(name, pin);
  }

  userId = getIdWithName(name);

  while (!exit) {
    print("\n ==============MENU============== \n\n");
    print("1.Widthdraw. \n2.Deposit \n3.Balance Inquiry \n4.Exit \n");
    if(userId == 0){
      print("5.Create Account \n 6.Delete Account \n");
    }
    Input = int.parse(stdin.readLineSync() ?? '0');

    if (Input == 1) {
      print("\nEnter amount: ");
      int amount = int.parse(stdin.readLineSync() ?? '0');

      print(Widthdraw(userId, amount));
    } else if (Input == 2) {
      print("\nEnter amount: ");
      int amount = int.parse(stdin.readLineSync() ?? '0');

      print(Deposit(userId, amount));
    } else if (Input == 3) {
      print(Check_Balance(userId));
    } else if (Input == 4) {
      exit = true;
    }
    else if(userId == 0){
      if(Input == 5){
        print(createAccount());
      }
      else if(Input == 6){

        print("\n Enter the name of the account holder: ");
        String delName = stdin.readLineSync() ?? 'null';
        print(deleteAccount(getIdWithName(delName)));
      }
    }
    else {
      print("\n Invalid Input!");
    }
  }

  // createAccount();
  // print(accounts);

  // Mustafa bhai,
  // Idhar aik menu bna dena jese aik ATM machine ka menu hota hy
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
      "Current_Balance": Balance
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
    "Current_Balance": Balance
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
