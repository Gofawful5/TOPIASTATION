/datum/preference/color/pod_hair_color
	savefile_key = "pod_hair_color"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SUPPLEMENTAL_FEATURES

/datum/preference/color/pod_hair_color/apply_to_human(mob/living/carbon/human/target, value)
	target.hair_color = value

/datum/preference/choiced/pod_hair
	savefile_key = "feature_pod_hair"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Podperson Hairstyle"
	should_generate_icons = TRUE

/datum/preference/choiced/pod_hair/init_possible_values()
	var/list/values = possible_values_for_sprite_accessory_list(GLOB.pod_hair_list)

	var/icon/head_icon = icon('icons/mob/species/human/bodyparts_greyscale.dmi', "pod_head_m")

	for (var/name in values)
		var/datum/sprite_accessory/accessory = GLOB.pod_hair_list[name]
		if (accessory == null || accessory.icon_state == null)
			continue

		var/icon/final_icon = new(head_icon)

		var/icon/beard_icon = values[name]
		beard_icon.Blend(COLOR_DARK_MODERATE_LIME_GREEN, ICON_MULTIPLY)
		final_icon.Blend(icon(accessory.icon, "m_pod_hair_[accessory.icon_state]_ADJ"), ICON_OVERLAY)

		final_icon.Crop(10, 19, 22, 31)
		final_icon.Scale(32, 32)

		values[name] = final_icon

	return values

/datum/preference/choiced/pod_hair/create_default_value()
	return pick(GLOB.pod_hair_list)

/datum/preference/choiced/pod_hair/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["pod_hair"] = value

/datum/preference/choiced/pod_hair/compile_constant_data()
	var/list/data = ..()

	data[SUPPLEMENTAL_FEATURE_KEY] = "pod_hair_color"

	return data
