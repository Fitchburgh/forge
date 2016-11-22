
# Heroku drag and backup to local.  
def main
  system 'heroku pg:backups capture'

  system 'curl -o latest.dump `heroku pg:backups public-url`'

  system 'pg_restore --verbose --clean --no-acl --no-owner -h localhost -U Fitchburgh -d forge_test latest.dump'
end

main if __FILE__ == $PROGRAM_NAME
