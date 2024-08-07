extends MarginContainer

var http_request: HTTPRequest
#
#func _ready():
	## Create and add the HTTPRequest node
	#http_request = HTTPRequest.new()
	#add_child(http_request)
	#http_request.connect("request_completed", self, "_on_request_completed")
	#
	## Start downloading the image
	#download_image("https://example.com/your-image.png")
#
#func download_image(url: String):
	## Request the image from the given URL
	#var error = http_request.request(url)
	#if error != OK:
		#print("An error occurred in the HTTP request: %d" % error)
#
#func _on_request_completed(result, response_code, headers, body):
	## Check if the request was successful
	#if response_code == 200:
		## Load the image from the downloaded data
		#var image = Image.new()
		#var error = image.load_png_from_buffer(body)
		#if error == OK:
			## Create a texture from the image
			#var texture = ImageTexture.new()
			#texture.create_from_image(image)
			## Assign the texture to the TextureRect
			#$TextureRect.texture = texture
		#else:
			#print("Failed to load image from buffer. Error: %d" % error)
	#else:
		#print("Failed to download image. HTTP response code: %d" % response_code)

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

	if compact:
		%BioContainer.hide()
