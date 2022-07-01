# Expense App

This development consists of creating an Salesforce app for manage expenses. The following artifacts were created:

- A custom object called `Expense`
- One LWC for visualize expense records
- One LWC for create expense records
- An apex class
- One dashboard to visualize a graphic of expenses by category and month
- A Salesforce app called `Expense app`

Within `Expense app` in the `home` tab you can view a the dashboard with a graphic of expenses by category and month. On the right side you can create new expenses.

![Expense App - Home tab](/repositoryimages/w1.png)

You are able to create unique expenses, weekly basis expenses or monthly basis expenses. You just need to fill all the fields and choose the recurrence. Pay attention that the dates are according to user timezone and locale.

![Create expense LWC](/repositoryimages/w2.png)

In the `Expense Listing` tab within the app you can view all the expenses created and there is a refresh button to get more updated and newly data.

![Expense App - Expense Listing tab](/repositoryimages/w3.png)

