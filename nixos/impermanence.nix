{ username, ... }:
{
  environment.persistence."/top/@" = {
    hideMounts = true;
    directories = [ ];
    files = [ ];
    users.${username} = {
      directories = [ ];
      files = [
        ".config/kwinoutputconfig.json"
      ];
    };
  };
}
