set :stage, :production

# Replace 127.0.0.1 with your server's IP address!
server '46.101.234.88', user: 'deploy', roles: %w{web app db}
