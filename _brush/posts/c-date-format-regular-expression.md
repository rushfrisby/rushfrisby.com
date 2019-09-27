
Use this regular expression to verify a US date format:

^([1-9]|0[1-9]|1[012])[- /.]([1-9]|0[1-9]|[12][0-9]|3[01])[- /.][0-9]{4}$

Here is a quick unit test:

[TestMethod] public void USDateRegex() { var usDateFormat = new Regex("^([1-9]|0[1-9]|1[012])[- /.]([1-9]|0[1-9]|[12][0-9]|3[01])[- /.][0-9]{4}$"); Assert.IsTrue(usDateFormat.IsMatch("1/19/1999")); Assert.IsTrue(usDateFormat.IsMatch("1-19-1999")); Assert.IsTrue(usDateFormat.IsMatch("01/19/1999")); Assert.IsTrue(usDateFormat.IsMatch("01-19-1999")); Assert.IsFalse(usDateFormat.IsMatch("1999/01/19")); Assert.IsFalse(usDateFormat.IsMatch("1999-01-19")); Assert.IsFalse(usDateFormat.IsMatch("99/99/1999")); Assert.IsFalse(usDateFormat.IsMatch("12/12/12345")); //this is not a valid date but matches the regex Assert.IsTrue(usDateFormat.IsMatch("02/31/1999")); }

This will also work with the RegularExpressionValidator control in ASP.NET. Do note that some dates do match the expression but are not valid such as 2/31. It turns out that using a regular expression for edge cases is not the best approach. A better solution is to use the [DateTime.TryParse](http://msdn.microsoft.com/en-us/library/system.datetime.tryparse.aspx) method or [DateTime.TryParseExact](http://msdn.microsoft.com/en-us/library/system.datetime.tryparseexact.aspx) for custom date formats. This will also accept British style dates with the year first (and possibly more that I haven’t tested) so it is much more flexible than using Regex. Here is another example with a quick unit test:

public bool IsValidDate(string date) { DateTime result; return DateTime.TryParse(date, out result); } [TestMethod] public void USDateTryParse() { Assert.IsTrue(IsValidDate("1/19/1999")); Assert.IsTrue(IsValidDate("1-19-1999")); Assert.IsTrue(IsValidDate("01/19/1999")); Assert.IsTrue(IsValidDate("01-19-1999")); Assert.IsTrue(IsValidDate("1999/01/19")); Assert.IsTrue(IsValidDate("1999-01-19")); Assert.IsFalse(IsValidDate("99/99/1999")); Assert.IsFalse(IsValidDate("12/12/12345")); Assert.IsFalse(IsValidDate("02/31/1999")); }


