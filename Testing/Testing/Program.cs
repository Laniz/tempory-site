// See https://aka.ms/new-console-template for more information
Console.WriteLine("Enter a number");

//read user input
var UserInput = Console.ReadLine();

int UserInputInt = int.Parse(UserInput);

List<int> doubledNumbers = new List<int>();

while (UserInputInt < 10)
{
    // Console.WriteLine($"This is the user input {UserInputInt}");
    Console.WriteLine(" ");
    var doubledNumber = UserInputInt * 2;
    Console.WriteLine($"This is the doubled number {doubledNumber}");
    doubledNumbers.Add(doubledNumber);
    Console.WriteLine(" ");
    Console.WriteLine($"{doubledNumber} has been added to the list");
    UserInputInt++;
}

int stringLength = 10;
static void doubled(int UserInputInt, int stringLength)
{
    List<int> doubledList2 = new List<int>();
    while (stringLength < 10)
    {
        var doubledNumber = UserInputInt * 2;
        Console.WriteLine($"This is the doubled number {doubledNumber}");
        stringLength++;
        doubledList2.Add(doubledNumber);
    }
}
 



// int[] numbers = {1, 2, 3, 4, 5 };
// foreach (int i in numbers)
// {
//     var doubledNumber = i * 2;
//     Console.WriteLine(doubledNumber);
// }