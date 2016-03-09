# MassRoots

This is a simple application that allows users to search for repositories on GitHub and display them in a view controller.  Repositories displayed include the repository name, author, description, updated time stamp, and languages. Selecting a repository will open and display a web view of the repository. Users can login with Github and be authenticated with OAuth. 

Technical choices include using AFNetworking framework for requests.  AFNetworking is a powerful open source framework that allows for easy http requests and operation queues. The Github API (https://developer.github.com/v3/) allows apps to connect to Github and perform RESTful operations. Using the Github Api with AFNetworking allowed for more control over searching repositories, authenticating users, and put/get requests.  Architectural choices in this project include MVC structure.  It consist of my Repository class for a model, SearchViewController/LoginViewController being the controllers, and RepositoryCell being part of the view.

I also have created a dictionary NSDictionary+github used for github repositories. The dictionary contains the key value pairs that is parsed from the json response including repository name, author, description, updated time stamp, and languages but can be expanded for any key values parsed from a Github response. For Example a get request for this repository looks like:

{
  "id": 53362904,
  "name": "MassRoots",
  "full_name": "rtuttleGit/MassRoots",
  "owner": {
    "login": "rtuttleGit",
    "id": 14857028,
    "avatar_url": "https://avatars.githubusercontent.com/u/14857028?v=3",
    "gravatar_id": "",
    "url": "https://api.github.com/users/rtuttleGit",
    "html_url": "https://github.com/rtuttleGit",
    "followers_url": "https://api.github.com/users/rtuttleGit/followers",
    "following_url": "https://api.github.com/users/rtuttleGit/following{/other_user}",
    "gists_url": "https://api.github.com/users/rtuttleGit/gists{/gist_id}",
    "starred_url": "https://api.github.com/users/rtuttleGit/starred{/owner}{/repo}",
                          .
                          .
                          .
    },
    .
    .
    .
}


