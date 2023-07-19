import 'dart:io';

List<Map> accounts = [
  {"Id": 0, "Name": "admin", "Pin": 0000, "Balance": 10}
];
List Ledger = [];

void main() {
  print("======Welcome to the Transaction Management System======");

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
    return ("Current balance is insufficient for this transaction.");
  } else {
    int Index = accounts.indexWhere((element) => element["Id"] == Id);

    Balance = Balance - Amount;

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

  Balance = Balance + Amount;

  accounts[Index]["Balance"] = Balance;

  return ("Transaction completed succesfully, Your Balance is: $Balance");
}
String createAccount(){

  String? name;
  int? pin;
  int Id = accounts.length;

  while(name == null){
      print("Enter Name:");
  name = stdin.readLineSync();
  }
  while(pin == null || pin < 4){
    print("Enter a PIN that is lonnger than Four digits");
    pin = int.parse(stdin.readLineSync() ?? '0');
  }

  accounts.add({
    "Id": Id,
    "Name": name,
    "Pin": pin,
    "Balance": 0
  });

  return("Account created succesfully");
}
String deleteAccount(int Id){
  accounts.removeWhere((element) => element["Id"] == Id);

  return("Account deleted succesfully");
}
int getIdWithName(String name){

  int Index = accounts.indexWhere((element) => element["Name"] == name);
  int Id = accounts[Index]["Id"];

  return Id;
}