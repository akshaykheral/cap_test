set :stage, :production
server '52.74.3.7',
user: 'ubuntu',
roles: %w{app},
ssh_options: {
	user: 'ubuntu', # overrides user setting above
	keys: %w(/home/akki/Desktop/keys/database_prod.pem),
	forward_agent: false,
	auth_methods: %w(publickey password),
	# password: ''
}