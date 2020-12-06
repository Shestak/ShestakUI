local T, C, L, _ = unpack(select(2, ...))
if C.skins.details ~= true or not IsAddOnLoaded("Details") then return end

----------------------------------------------------------------------------------------
--	Details skin
----------------------------------------------------------------------------------------
hooksecurefunc(_detalhes.gump, "CreateNewLine", function(_, instancia, index)
	local bar = _G["DetailsBarra_"..instancia.meu_id.."_"..index]
	local icon = _G["DetailsBarra_IconFrame_"..instancia.meu_id.."_"..index]

	if bar and not bar.backdrop then
		bar:CreateBackdrop("Defalt")
		bar.backdrop:SetPoint("TOPLEFT", icon, -2, 2)

		bar.bg = bar:CreateTexture(nil, "BORDER")
		bar.bg:SetAllPoints(bar)
		bar.bg:SetTexture(C.media.texture)
		bar.bg:SetVertexColor(.6, .6, .6, 0.25)
	end

	local frame = _G["DetailsUpFrameInstance"..instancia.meu_id]
	if not frame.b then
		frame.b = CreateFrame("Frame", nil, frame:GetParent())
		frame.b:SetTemplate("Overlay")
		frame.b:SetPoint("TOPLEFT", frame, "TOPLEFT", -23, 2)
		frame.b:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 34, 4)
	end
end)

hooksecurefunc(_detalhes, "SetFontOutline", function(_, fontString)
	local fonte, size = fontString:GetFont()
	if fonte == "Interface\\AddOns\\ShestakUI\\Media\\Fonts\\Pixel.ttf" then
		fontString:SetFont(fonte, size, "MONOCHROMEOUTLINE")
		if fontString:GetShadowColor() then
			fontString:SetShadowColor(0, 0, 0, 0)
		end
	end
end)

local skinTable = {
	file = [[Interface\AddOns\Details\images\skins\classic_skin_v1.blp]],
	author = "Shestak",
	version = "1.0",
	site = "unknown",
	desc = "ShestakUI style skin.",

	--micro frames
	micro_frames = {
		color = {1, 1, 1, 1},
		font = "Hooge",
		size = 8,
		textymod = 1,
	},

	can_change_alpha_head = true,
	icon_anchor_main = {-1, -5},
	icon_anchor_plugins = {-7, -13},
	icon_plugins_size = {19, 18},

	--anchors:
	icon_point_anchor = {-37, 0},
	left_corner_anchor = {-107, 0},
	right_corner_anchor = {96, 0},

	icon_point_anchor_bottom = {-37, 12},
	left_corner_anchor_bottom = {-107, 0},
	right_corner_anchor_bottom = {96, 0},

	icon_on_top = true,
	icon_ignore_alpha = true,
	icon_titletext_position = {3, 3},

	--overwrites
	instance_cprops = {
		["show_statusbar"] = false,
		["menu_icons_size"] = 0.850000023841858,
		["color"] = {
			0, -- [1]
			0, -- [2]
			0, -- [3]
			0, -- [4]
		},
		["menu_anchor"] = {
			16, -- [1]
			6, -- [2]
			["side"] = 2,
		},
		["bg_r"] = 1,
		["hide_out_of_combat"] = false,
		["following"] = {
			["bar_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
			},
			["enabled"] = false,
			["text_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
			},
		},
		["color_buttons"] = {
			1, -- [1]
			1, -- [2]
			1, -- [3]
			1, -- [4]
		},
		["skin_custom"] = "",
		["menu_anchor_down"] = {
			16, -- [1]
			-3, -- [2]
		},
		["micro_displays_locked"] = true,
		["row_show_animation"] = {
			["anim"] = "Fade",
			["options"] = {
			},
		},
		["tooltip"] = {
			["n_abilities"] = 3,
			["n_enemies"] = 3,
		},
		["total_bar"] = {
			["enabled"] = false,
			["only_in_group"] = true,
			["icon"] = "Interface\\ICONS\\INV_Sigil_Thorim",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
			},
		},
		["show_sidebars"] = false,
		["instance_button_anchor"] = {
			-27, -- [1]
			1, -- [2]
		},
		["row_info"] = {
			["spec_file"] = "Interface\\AddOns\\Details\\images\\spec_icons_normal",
			["textL_outline"] = true,
			["textR_outline"] = true,
			["textL_outline_small"] = false,
			["textR_outline_small"] = false,
			["texture_highlight"] = "Interface\\FriendsFrame\\UI-FriendsList-Highlight",
			["textR_show_data"] = {
				true, -- [1]
				true, -- [2]
				true, -- [3]
			},
			["textL_enable_custom_text"] = false,
			["fixed_text_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
			},
			["space"] = {
				["right"] = 0,
				["left"] = 0,
				["between"] = 7,
			},
			["texture_background_class_color"] = false,
			["start_after_icon"] = true,
			["font_face_file"] = "Interface\\AddOns\\ShestakUI\\Media\\Fonts\\Pixel.ttf",
			["backdrop"] = {
				["enabled"] = false,
				["size"] = 12,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["texture"] = "Details BarBorder 2",
			},
			["font_size"] = 8,
			["height"] = 14,
			["texture_file"] = "AddOns\\ShestakUI\\Media\\Textures\\Texture.tga",
			["icon_file"] = "Interface\\AddOns\\Details\\images\\classes_small",
			["textR_bracket"] = "(",
			["textR_enable_custom_text"] = false,
			["fixed_texture_color"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
			},
			["textL_show_number"] = true,
			["textL_custom_text"] = "{data1}. {data3}{data2}",
			["textR_custom_text"] = "{data1} ({data2}, {data3}%)",
			["fixed_texture_background_color"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0, -- [4]
			},
			["models"] = {
				["upper_model"] = "Spells\\AcidBreath_SuperGreen.M2",
				["lower_model"] = "World\\EXPANSION02\\DOODADS\\Coldarra\\COLDARRALOCUS.m2",
				["upper_alpha"] = 0.5,
				["lower_enabled"] = false,
				["lower_alpha"] = 0.1,
				["upper_enabled"] = false,
			},
			["textR_class_colors"] = false,
			["texture_custom"] = "AddOns\\ShestakUI\\Media\\Textures\\Texture.tga",
			["texture"] = "Smooth!",
			["textL_class_colors"] = false,
			["alpha"] = 1,
			["no_icon"] = false,
			["texture_background"] = "Smooth!",
			["texture_background_file"] = "AddOns\\ShestakUI\\Media\\Textures\\Texture.tga",
			["font_face"] = "Hooge",
			["font_shadow"] = "OUTLINE",
			["texture_class_colors"] = true,
			["percent_type"] = 1,
			["fast_ps_update"] = false,
			["textR_separator"] = ",",
			["use_spec_icons"] = true,
		},
		["plugins_grow_direction"] = 1,
		["menu_alpha"] = {
			["enabled"] = false,
			["onleave"] = 1,
			["ignorebars"] = false,
			["iconstoo"] = true,
			["onenter"] = 1,
		},
		["micro_displays_side"] = 2,
		["grab_on_top"] = false,
		["strata"] = "LOW",
		["bars_grow_direction"] = 1,
		["bg_alpha"] = 0,
		["ignore_mass_showhide"] = false,
		["hide_in_combat_alpha"] = 0,
		["menu_icons"] = {
			true, -- [1]
			true, -- [2]
			true, -- [3]
			true, -- [4]
			true, -- [5]
			false, -- [6]
			["space"] = -2,
			["shadow"] = false,
		},
		["auto_hide_menu"] = {
			["left"] = false,
			["right"] = false,
		},
		["statusbar_info"] = {
			["alpha"] = 0,
			["overlay"] = {
				0.333333333333333, -- [1]
				0.333333333333333, -- [2]
				0.333333333333333, -- [3]
			},
		},
		["window_scale"] = 1,
		["libwindow"] = {
			["y"] = 90.9987335205078,
			["x"] = -80.0020751953125,
			["point"] = "BOTTOMRIGHT",
		},
		["backdrop_texture"] = "Details Ground",
		["hide_icon"] = true,
		["bg_b"] = 0.0941176470588235,
		["toolbar_side"] = 1,
		["bg_g"] = 0.0941176470588235,
		["desaturated_menu"] = false,
		["wallpaper"] = {
			["enabled"] = false,
			["texcoord"] = {
				0, -- [1]
				1, -- [2]
				0, -- [3]
				0.7, -- [4]
			},
			["overlay"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["anchor"] = "all",
			["height"] = 114.042518615723,
			["alpha"] = 0.5,
			["width"] = 283.000183105469,
		},
		["stretch_button_side"] = 1,
		["attribute_text"] = {
			["enabled"] = true,
			["shadow"] = true,
			["side"] = 1,
			["text_size"] = 8,
			["custom_text"] = "{name}",
			["text_face"] = "Hooge",
			["anchor"] = {
				-19, -- [1]
				9, -- [2]
			},
			["text_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["enable_custom_text"] = false,
			["show_timer"] = {
				true, -- [1]
				true, -- [2]
				true, -- [3]
			},
		},
		["bars_sort_direction"] = 1,
	},
}

_detalhes.skins["Minimalistic v2"] = skinTable

local lower_instance = _detalhes:GetLowerInstanceNumber()
if lower_instance then
	for i = lower_instance, #_detalhes.tabela_instancias do
		local instance = Details:GetInstance(i)
		if instance then
			for j = 1, instance:GetNumRows() do
				local bar = _G["DetailsBarra_Statusbar_"..i.."_"..j]
				local icon = _G["DetailsBarra_IconFrame_"..i.."_"..j]
				if bar and not bar.backdrop then
					bar:CreateBackdrop("Defalt")
					bar.backdrop:SetPoint("TOPLEFT", icon, -2, 2)

					bar.bg = bar:CreateTexture(nil, "BORDER")
					bar.bg:SetAllPoints(bar)
					bar.bg:SetTexture(C.media.texture)
					bar.bg:SetVertexColor(.6, .6, .6, 0.25)
				end
			end

			local frame = _G["DetailsUpFrameInstance"..i]
			frame.b = CreateFrame("Frame", nil, frame:GetParent())
			frame.b:SetTemplate("Overlay")
			frame.b:SetPoint("TOPLEFT", frame, "TOPLEFT", -23, 2)
			frame.b:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 34, 4)

			instance:ChangeSkin("Minimalistic v2")
		end
	end
end