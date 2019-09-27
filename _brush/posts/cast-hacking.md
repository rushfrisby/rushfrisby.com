
Have you ever wanted to cast a base class into a subclass? Consider these two classes:

public class Animal { } public class Dog : Animal { }

Because of the inheritance we can create an Animal from a Dog because we know that Dog has all of the necessary properties to set on Animal. Quick example:

var dog = new Dog(); var animal = (Animal) dog;

This works in .NET. But what if you wanted to create a Dog from an Animal? Unfortunately Dog may have some properties that Animal doesn’t and so you will get an exception at runtime when trying to cast from an Animal to a Dog:

var animal = new Animal(); var dog = (Dog) animal;

Causes this runtime exception:

An unhandled exception of type 'System.InvalidCastException' occurred. Additional information: Unable to cast object of type 'Animal' to type 'Dog'.

Getting around this casting issue means you would have to create a new Animal, then for every property on Animal set the value to the corresponding property on Dog. THAT SUCKS. Who has time or the memory to keep that conversion up-to-date? What happens when you add a new property to Animal – will you remember to update this property-copying code as well?

It wasn’t intended specifically for getting around casting issues but for property copying [Automapper](https://github.com/AutoMapper/AutoMapper) is AWESOME! It does pretty much what you would expect. It maps the properties of one class to another so you don’t have this problem of manually maintaining the mappings. Here is how you can create an Animal from a Dog using Automapper:

Mapper.CreateMap<Animal, Dog>(); var animal = new Animal(); var dog = Mapper.Map<Animal, Dog>(animal);

For the properties of Dog that Animal doesn’t have, if the property is a value type it’s value will be the type’s default value and for reference types the value will be null. Simple huh?


