{ config, lib, username, user, ... }:

{
  programs.git = {
    enable = true;
    userName = user.name;
    userEmail = user.email;
  };
}
