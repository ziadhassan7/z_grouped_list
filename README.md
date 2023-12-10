A custom list that separates your list of data into groups with seperators!

### Features
Supports ListViews and GridViews

## Usage

Important!!!
do not forget to wrap your code with an `Expanded` or a `SizedBox`.

**Simple List implementation:**
```dart
ZGroupedList(
              // your items list
              items: books,
              // What element should you sort by?
              sortBy: (item){
                int year = item['year'];
                return year;
              },
              // Item widget
              itemBuilder: (context, item){
                String? name = item['name'];
                return Text(name ?? "empty");
              },
              // Group separator widget
              groupSeparatorBuilder: (year) {
                return Text(year.toString(),);
              }, ),
```

**Grid List implementation:**
```dart
ZGroupedList.grid(
              // Show 3 items horizontally
              crossAxisCount: 3,

              // All items list
              items: books,
              // What element should you sort by?
              sortBy: (item){
                int year = item['year'];
                return year;
              },
              // Item widget
              itemBuilder: (context, item){
                String? name = item['name'];
                return Text(name ?? "empty");
              },
              // Group separator widget
              groupSeparatorBuilder: (year) {
                return Text(year.toString(),);
              },

              // Custom grid delegate (optional)
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 80,
                  childAspectRatio: 5 / 9,
                  crossAxisSpacing: 25,
                  mainAxisSpacing: 15),
            ),
```



### Parameters
**Normal List:**

| Name                  | Description                                             | Required | Default value |
| :-------------------- |:-------------------------------------------------------:| --------:| -------------:|
| items                 | A list of the data you want to display in the list      | required | -             |
| sortBy                | Function which maps an element to its grouped value     | required | -             |
| itemBuilder           | Function that let you build the item widget             | required | -             |
| groupSeparatorBuilder | Function that let you build the group separator widget  | required | -             |
| descendingOrder       | Is your data organized in a decending order             | no       | true          |

**Extra for Grid List:**

| Name                  | Description                                             | Required | Default value |
| :-------------------- |:-------------------------------------------------------:| --------:| -------------:|
| crossAxisCount        | how many items horizontally in a grid                   | no       | 1             |
| gridDelegate          | pass in a custom gridDelegate                           | no       | -             |
