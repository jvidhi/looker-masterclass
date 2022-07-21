connection: "looker-private-demo"


view: a {dimension: dim {}}
view: b {dimension: dim {}}
view: c {dimension: dim {}}
view: d {dimension: dim {}}
view: e {dimension: dim {}}
view: child {dimension: dim {}}

explore: parent_one {
  from: a
  extension: required
  join: b {}
  join: c {}
}

explore: parent_two {
  from: b
  join: d {}
  join: e {}
}

explore: child {
  view_name: a
  # extends: [parent_one,  parent_two]
}
