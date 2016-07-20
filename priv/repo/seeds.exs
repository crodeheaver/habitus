# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Habitus.Repo.insert!(%Habitus.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Habitus.User
alias Habitus.Page
alias Habitus.Tag
alias Habitus.Comment
alias Habitus.Role

Habitus.Repo.insert!(Role.changeset %Role{}, %{
    role_type: "admin"
  })
Habitus.Repo.insert!(Role.changeset %Role{}, %{
    role_type: "user"
})
Habitus.Repo.insert!(Role.changeset %Role{}, %{
    role_type: "author"
  })  


Habitus.Repo.insert!(User.changeset %User{}, %{
    display_name: "admin",
    email: "admin@admin.com",
    role_id: 1,
    password: "notagoodpassword",
    password_confirmation: "notagoodpassword"
  })

Habitus.Repo.insert!(User.changeset %User{}, %{
    display_name: "crodeheaver",
    first_name: "Colby",
    last_name: "Rodeheaver",
    email: "carodeheaver@gmail.com",
    role_id: 1,
    password: "notagoodpassword",
    password_confirmation: "notagoodpassword"
  })

Habitus.Repo.insert!(User.changeset %User{}, %{
    display_name: "nbland",
    first_name: "Nathan",
    last_name: "Bland",
    email: "nbland@gmail.com",
    password: "notagoodpassword",
    password_confirmation: "notagoodpassword",
    role_id: 1
  })
  
Habitus.Repo.insert!(User.changeset %User{}, %{
    display_name: "kwade",
    first_name: "Keith",
    last_name: "Wade",
    email: "kwade@gmail.com",
    password: "notagoodpassword",
    password_confirmation: "notagoodpassword",
    role_id: 2
  })

Habitus.Repo.insert!(%Page{
    title: "Index",
    content: "This is the Index page!",
    alias: "index",
    enable_comments: true
  })

Habitus.Repo.insert!(%Page{
    title: "About Me",
    content: "This is a new Page",
    alias: "about-me",
    enable_comments: true
  })
  
Habitus.Repo.insert!(%Comment{
    content: "This is my favorite page!",
    page_id: 1,
    user_id: 3
  })
Habitus.Repo.insert!(%Comment{
    content: "Mine too!",
    page_id: 1,
    user_id: 2
  })
  
