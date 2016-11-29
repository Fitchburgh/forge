# every 1.day do
  system 'heroku pg:backups capture'
  system 'curl -o latest.dump `heroku pg:backups public-url`'
  system 'pg_restore --verbose --clean --no-acl --no-owner -h localhost -U Fitchburgh -d forge_test latest.dump'
  # system 'aws s3 cp s3://yazuapgbackup/latest.dump ../yazua_backup/' if system 'pg_restore --verbose --clean --no-acl --no-owner -h localhost -U Fitchburgh -d forge_test latest.dump'
  #
  # system 'aws s3 cp latest.dump s3://yazuapgbackup/'
# end
