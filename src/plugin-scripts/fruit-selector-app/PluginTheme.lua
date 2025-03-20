local PluginTheme = {
    Colors = {
        Primary =  {
            Main =  Color3.fromHex("#ff8906"), --[[ Color checkbox ]]
			Dark =   Color3.fromHex("#ff0000"),
			Light =   Color3.fromHex("#00ff00"),
			Contrast =   Color3.fromHex("#0000ff"),
        },
        Secondary =  {
            Main =  Color3.fromHex("#fffffe"),
			Dark =   Color3.fromHex("#ff0000"),
			Light =   Color3.fromHex("#00ff00"),
			Contrast =   Color3.fromHex("#0000ff"),
        },
        Neutral =  {
            Main =  Color3.fromHex("#ff8906"), --[[ Color button when is available ]]
			Dark =  Color3.fromHex("#E8E8E7"),
			Light =  Color3.fromHex("#a7a9be"),
			
        },
        NeutralContent =  {
            Main =  Color3.fromHex("#0f0e17"),
			Dark =   Color3.fromHex("#824603"), --[[ Color checkbox disabled ]]
			Light =   Color3.fromHex("#00ff00"),
			Contrast =   Color3.fromHex("#0000ff"),
        },
        Accent =  {
            Main =  Color3.fromHex("#fffffe"),
			Dark =   Color3.fromHex("#ff0000"),
			Light =   Color3.fromHex("#00ff00"),
			Contrast =   Color3.fromHex("#0000ff"),
        },

		Base =  {
            Main =  Color3.fromHex("#fffffe"),
			Dark =   Color3.fromHex("#ff0000"),
			Light =   Color3.fromHex("#00ff00"),
			Contrast =   Color3.fromHex("#0000ff"),
        },

		BaseContent =  {
            Main =  Color3.fromHex("#824603"), --[[ button disabled ]]
			Dark =   Color3.fromHex("#ff0000"),
			Light =   Color3.fromHex("#00ff00"),
			Contrast =   Color3.fromHex("#0000ff"),
        },

		Success =  {
            Main =  Color3.fromHex("#4BB543"), --[[ button disabled ]]
			Dark =   Color3.fromHex("#ff0000"),
			Light =   Color3.fromHex("#00ff00"),
			Contrast =   Color3.fromHex("#0000ff"),
        },
		
		Background  =  {
            Main =  Color3.fromHex("#0f0e17"),
        },
    }
}

return PluginTheme
--[[ 
type ThemeColor = {
	Main: Color3?,
	Dark: Color3?,
	Light: Color3?,
	Contrast: Color3?,

	[string]: Color3?,
}
export type ThemeSpec = {
	Colors: {
		Primary: ThemeColor?,
		Secondary: ThemeColor?,
		Accent: ThemeColor?,

		Neutral: ThemeColor?,
		NeutralContent: ThemeColor?,

		Base: ThemeColor?,
		BaseContent: ThemeColor?,

		Success: ThemeColor?,
		Error: ThemeColor?,
		Warning: ThemeColor?,
		Info: ThemeColor?,

		[string]: ThemeColor?,
	}?,
	Font: {
		Body: string?,
		Heading: string?,
		Monospace: string?,

		[string]: string?,
	}?,
	FontWeight: {
		Body: Enum.FontWeight?,
		Bold: Enum.FontWeight?,
		Heading: Enum.FontWeight?,

		[string]: Enum.FontWeight?,
	}?,
	TextSize: {
		Base: number?,
		["0.75"]: number?,
		["0.875"]: number?,
		["1"]: number?,
		["1.125"]: number?,
		["1.25"]: number?,
		["1.5"]: number?,
		["1.875"]: number?,
		["2.25"]: number?,
		["3"]: number?,
		["3.75"]: number?,
		["4.5"]: number?,

		[string]: number?,
	}?,
	Spacing: {
		Base: number?,
		["0"]: number?,
		["0.25"]: number?,
		["0.5"]: number?,
		["0.75"]: number?,
		["1"]: number?,
		["1.5"]: number?,
		["2"]: number?,
		["3"]: number?,
		["4"]: number?,
		["6"]: number?,
		["8"]: number?,
		["12"]: number?,
		["16"]: number?,
		["24"]: number?,
		["32"]: number?,
		["40"]: number?,
		["48"]: number?,

		[string]: number?,
	}?,
	CornerRadius: {
		Base: number?,
		["0"]: number?,
		["0.5"]: number?,
		["1"]: number?,
		["1.5"]: number?,
		["2"]: number?,
		["3"]: number?,
		["4"]: number?,
		["6"]: number?,
		Full: number?,

		[string]: number?,
	}?,
	StrokeThickness: {
		Base: number?,
		["0"]: number?,
		["1"]: number?,
		["2"]: number?,
		["3"]: number?,
		["4"]: number?,
		["8"]: number?,

		[string]: number?,
	}?,
	SpringSpeed: {
		Base: number?,
		["0.1"]: number?,
		["0.175"]: number?,
		["0.25"]: number?,
		["0.375"]: number?,
		["0.5"]: number?,
		["0.75"]: number?,
		["1"]: number?,
		["1.5"]: number?,
		["2"]: number?,
		Immediate: number?,

		[string]: number?,
	}?,
	SpringDampening: {
		Base: number?,
		["0.1"]: number?,
		["0.175"]: number?,
		["0.25"]: number?,
		["0.375"]: number?,
		["0.5"]: number?,
		["0.75"]: number?,
		["1"]: number?,
		["1.5"]: number?,
		["2"]: number?,
		["5"]: number?,
		["10"]: number?,
		Full: number?,

		[string]: number?,
	}?,
	Emphasis: {
		Light: number?,
		Regular: number?,
		Strong: number?,
		Contrast: number?,

		[string]: number?,
	}?,
	Sound: {
		Hover: Sound?,
		Click: Sound?,
		Focus: Sound?,
		Switch: Sound?,

		[string]: Sound?,
	}?,

	[string]: any?,
}

return nil ]]