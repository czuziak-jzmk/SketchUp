#!/usr/bin/env ruby
# Pull in API hooks 
require 'sketchup.rb'

def exportImg
    model = Sketchup.active_model
    imglocation = UI.select_directory(
    title: "Select Image Directory",
    directory: File.expand_path('~'), # User's HOME dir
    select_multiple: false
    )

    #get materials in project.
    model.materials.each { |material|
        if material.texture != nil 
            basename = File.basename(material.texture.filename)
            path = File.join(imglocation, basename)
            material.texture.write(path, colorize = true)
            puts path 
        end
    }
end

#menu item 
UI.menu("Plugins").add_item("Texture Image Export") {
    UI.messagebox("Export Texture Images")
    exportImg
}
