extends MarginContainer

var _http_request: HTTPRequest
var _avatar_url: String
var _showing_chibi: bool = true


func initialize(hero: Hero, compact: bool) -> void:
	%Name.text = hero.name
	%Tier.texture = load(SpriteManager.get_tier_sprite_path(hero.tier))
	%Gender.set_stat_value(str(Enums.Gender.keys()[hero.gender]))
	%Type.set_stat_value(str(Enums.HeroType.keys()[hero.type]))
	%Health.set_stat_value(str(hero.max_hp))
	%Attack.set_stat_value(str(hero.attack))
	%Bio.text = hero.bio
	%HeroCosmetics.initialize(hero.sprite_id)
	%HeroCosmetics.play_idle()

	_http_request = HTTPRequest.new()
	add_child(_http_request)
	_http_request.request_completed.connect(_on_request_completed)
	download_image(hero.avatar_url)

	if compact:
		%BioContainer.hide()


func download_image(url: String):
	_avatar_url = url
	var error = _http_request.request(url)
	if error != OK:
		print("An error occurred in the HTTP request: %d" % error)


func _on_request_completed(_result, response_code, _headers, body):
	# Check if the request was successful
	if response_code == 200:
		# Load the image from the downloaded data
		var image = Image.new()
		var error = image.load_jpg_from_buffer(body)
		if error == OK:
			# Create a texture from the image
			var texture = ImageTexture.create_from_image(image)
			# Assign the texture to the TextureRect
			%AvatarTextureRect.texture = texture
		else:
			print("Failed to load image from buffer. URL: %s. Error: %d" % [_avatar_url, error])
	else:
		print("Failed to download image. URL: %s HTTP response code: %d" % [_avatar_url, response_code])


func _on_button_pressed() -> void:
	if _showing_chibi:
		%AvatarContainer.show()
		%HeroCosmetics.hide()
		_showing_chibi = false
	else:
		%HeroCosmetics.show()
		%AvatarContainer.hide()
		_showing_chibi = true
