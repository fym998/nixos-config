{ username, ... }:
{
  environment.persistence."/top/@persistent" = {
    hideMounts = true;
    directories = [ ];
    files = [ ];
    users.${username} = {
      directories = [ ];
      files = [

      ];
    };
  };
}
