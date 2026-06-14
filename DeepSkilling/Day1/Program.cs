using System;

namespace DesignPatternsAndPrinciples
{
    // ==========================
    // SOLID PRINCIPLES
    // ==========================

    // SRP - Single Responsibility Principle
    class ReportGenerator
    {
        public void GenerateReport()
        {
            Console.WriteLine("Report Generated");
        }
    }

    class ReportSaver
    {
        public void SaveReport()
        {
            Console.WriteLine("Report Saved");
        }
    }

    // OCP - Open Closed Principle
    interface IDiscount
    {
        double GetDiscount();
    }

    class StudentDiscount : IDiscount
    {
        public double GetDiscount() => 10;
    }

    class EmployeeDiscount : IDiscount
    {
        public double GetDiscount() => 20;
    }

    // LSP - Liskov Substitution Principle
    class Bird
    {
        public virtual void Move()
        {
            Console.WriteLine("Bird Moving");
        }
    }

    class Sparrow : Bird
    {
        public override void Move()
        {
            Console.WriteLine("Sparrow Flying");
        }
    }

    // ISP - Interface Segregation Principle
    interface IWorkable
    {
        void Work();
    }

    interface IEatable
    {
        void Eat();
    }

    class Human : IWorkable, IEatable
    {
        public void Work()
        {
            Console.WriteLine("Human Working");
        }

        public void Eat()
        {
            Console.WriteLine("Human Eating");
        }
    }

    // DIP - Dependency Inversion Principle
    interface IMessageService
    {
        void SendMessage();
    }

    class EmailService : IMessageService
    {
        public void SendMessage()
        {
            Console.WriteLine("Email Sent");
        }
    }

    class Notification
    {
        private readonly IMessageService _service;

        public Notification(IMessageService service)
        {
            _service = service;
        }

        public void Notify()
        {
            _service.SendMessage();
        }
    }

    // ==========================
    // CREATIONAL PATTERNS
    // ==========================

    // Singleton Pattern
    class Singleton
    {
        private static Singleton instance;

        private Singleton() { }

        public static Singleton GetInstance()
        {
            if (instance == null)
                instance = new Singleton();

            return instance;
        }

        public void Show()
        {
            Console.WriteLine("Singleton Instance Accessed");
        }
    }

    // Factory Pattern
    interface IVehicle
    {
        void Drive();
    }

    class Car : IVehicle
    {
        public void Drive()
        {
            Console.WriteLine("Driving Car");
        }
    }

    class Bike : IVehicle
    {
        public void Drive()
        {
            Console.WriteLine("Driving Bike");
        }
    }

    class VehicleFactory
    {
        public static IVehicle CreateVehicle(string type)
        {
            if (type == "Car")
                return new Car();

            return new Bike();
        }
    }

    // Builder Pattern
    class House
    {
        public string Walls { get; set; }
        public string Roof { get; set; }
    }

    class HouseBuilder
    {
        private House house = new House();

        public HouseBuilder BuildWalls()
        {
            house.Walls = "Concrete Walls";
            return this;
        }

        public HouseBuilder BuildRoof()
        {
            house.Roof = "Strong Roof";
            return this;
        }

        public House Build()
        {
            return house;
        }
    }

    // ==========================
    // STRUCTURAL PATTERNS
    // ==========================

    // Adapter Pattern
    class OldPrinter
    {
        public void PrintOld()
        {
            Console.WriteLine("Old Printer Printing");
        }
    }

    interface IPrinter
    {
        void Print();
    }

    class PrinterAdapter : IPrinter
    {
        private OldPrinter oldPrinter = new OldPrinter();

        public void Print()
        {
            oldPrinter.PrintOld();
        }
    }

    // Decorator Pattern
    interface ICoffee
    {
        string GetDescription();
    }

    class SimpleCoffee : ICoffee
    {
        public string GetDescription()
        {
            return "Coffee";
        }
    }

    class MilkDecorator : ICoffee
    {
        private ICoffee coffee;

        public MilkDecorator(ICoffee coffee)
        {
            this.coffee = coffee;
        }

        public string GetDescription()
        {
            return coffee.GetDescription() + " + Milk";
        }
    }

    // Proxy Pattern
    interface IInternet
    {
        void Connect();
    }

    class RealInternet : IInternet
    {
        public void Connect()
        {
            Console.WriteLine("Connected to Internet");
        }
    }

    class InternetProxy : IInternet
    {
        private RealInternet internet = new RealInternet();

        public void Connect()
        {
            Console.WriteLine("Proxy Checking Access...");
            internet.Connect();
        }
    }

    // ==========================
    // BEHAVIORAL PATTERNS
    // ==========================

    // Observer Pattern
    interface IObserver
    {
        void Update(string message);
    }

    class Subscriber : IObserver
    {
        public void Update(string message)
        {
            Console.WriteLine("Subscriber Received: " + message);
        }
    }

    class YouTubeChannel
    {
        private IObserver observer;

        public void Subscribe(IObserver obs)
        {
            observer = obs;
        }

        public void UploadVideo()
        {
            observer?.Update("New Video Uploaded");
        }
    }

    // Strategy Pattern
    interface IPaymentStrategy
    {
        void Pay(int amount);
    }

    class CreditCardPayment : IPaymentStrategy
    {
        public void Pay(int amount)
        {
            Console.WriteLine($"Paid ₹{amount} using Credit Card");
        }
    }

    class UpiPayment : IPaymentStrategy
    {
        public void Pay(int amount)
        {
            Console.WriteLine($"Paid ₹{amount} using UPI");
        }
    }

    class PaymentContext
    {
        private IPaymentStrategy strategy;

        public PaymentContext(IPaymentStrategy strategy)
        {
            this.strategy = strategy;
        }

        public void ExecutePayment(int amount)
        {
            strategy.Pay(amount);
        }
    }

    // Command Pattern
    interface ICommand
    {
        void Execute();
    }

    class Light
    {
        public void TurnOn()
        {
            Console.WriteLine("Light Turned ON");
        }
    }

    class LightCommand : ICommand
    {
        private Light light;

        public LightCommand(Light light)
        {
            this.light = light;
        }

        public void Execute()
        {
            light.TurnOn();
        }
    }

    // ==========================
    // MAIN METHOD
    // ==========================

    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("===== SOLID PRINCIPLES =====");

            ReportGenerator rg = new ReportGenerator();
            rg.GenerateReport();

            ReportSaver rs = new ReportSaver();
            rs.SaveReport();

            IDiscount discount = new StudentDiscount();
            Console.WriteLine("Discount: " + discount.GetDiscount() + "%");

            Bird bird = new Sparrow();
            bird.Move();

            Human human = new Human();
            human.Work();
            human.Eat();

            Notification notification =
                new Notification(new EmailService());
            notification.Notify();

            Console.WriteLine("\n===== CREATIONAL PATTERNS =====");

            Singleton s = Singleton.GetInstance();
            s.Show();

            IVehicle vehicle =
                VehicleFactory.CreateVehicle("Car");
            vehicle.Drive();

            House house = new HouseBuilder()
                .BuildWalls()
                .BuildRoof()
                .Build();

            Console.WriteLine(
                $"{house.Walls}, {house.Roof}");

            Console.WriteLine("\n===== STRUCTURAL PATTERNS =====");

            IPrinter printer = new PrinterAdapter();
            printer.Print();

            ICoffee coffee =
                new MilkDecorator(new SimpleCoffee());

            Console.WriteLine(coffee.GetDescription());

            IInternet internet = new InternetProxy();
            internet.Connect();

            Console.WriteLine("\n===== BEHAVIORAL PATTERNS =====");

            YouTubeChannel channel =
                new YouTubeChannel();

            channel.Subscribe(new Subscriber());
            channel.UploadVideo();

            PaymentContext payment =
                new PaymentContext(new UpiPayment());

            payment.ExecutePayment(500);

            Light light = new Light();
            ICommand command =
                new LightCommand(light);

            command.Execute();
        }
    }
}
