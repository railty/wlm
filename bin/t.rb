def table_for(collection, *args)
  puts collection
  debugger
  puts collection
end

table_for("one")
table_for("one", "two")
table_for "one", "two", "three"
table_for("one", "two", "three")
table_for("one", ["two", "three"])
