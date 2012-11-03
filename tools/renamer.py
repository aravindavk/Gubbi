#!/usr/bin/python
# -*- coding: utf-8 -*-
import sys
import yaml
import string
import fontforge
import shutil

def apply_featurefile(feature_file):
    for lookup in font.gsub_lookups:
        font.removeLookup(lookup)

    for lookup in font.gpos_lookups:
        font.removeLookup(lookup)        

    font.mergeFeature(feature_file)
    font.save()

   
def rename_glyph(old_name, new_name):
    # print font[old_name].glyphname
    font[old_name].glyphname = new_name

def replace_in_featurefile(content, old_name, new_name):
    if old_name == new_name:
        return content
        
    p1 = '\\' + old_name + ' '
    r1 = '\\' + new_name + ' '

    p2 = '\\' + old_name + ';'
    r2 = '\\' + new_name + ';'

    content = string.replace(content, p1, r1)
    content = string.replace(content, p2, r2)
    return content
    
    
if __name__ == "__main__":
    replacements2 = yaml.load(open("replacements.yml"))

    # Copy the Original sfd file
    shutil.copy("../Gubbi_before_rename.sfd", "../Gubbi.sfd")
    
    # Get old feature file
    font_orig = fontforge.open("../Gubbi_before_rename.sfd")
    font_orig.generateFeatureFile("/tmp/Gubbi_old.fea")
    
    font = fontforge.open("../Gubbi.sfd")
    font.encoding   = "Unicode"
        
    feature_file_content = open("/tmp/Gubbi_old.fea").read()

    result = feature_file_content

    for p in replacements2:
        rename_glyph(p, replacements2[p])
        result = replace_in_featurefile(result, p, replacements2[p])

    # Fixes
    rename_glyph("U0CB0_U0CCD.rphf", "glyph_arkavattu")
    rename_glyph("U0C9E_U0CCD.blwf", "vattu_nya")
    rename_glyph("hale_glyph_ro", "glyph_hale_ro")
    result = replace_in_featurefile(result, "M_c.rphf", "glyph_arkavattu")
    result = replace_in_featurefile(result, "less_c.blwf", "vattu_nya")
    result = replace_in_featurefile(result, "hale_ro", "glyph_hale_ro")
    
    font.save()
    f = open("/tmp/Gubbi_new.fea", "w")
    f.write(result)
    f.close()
    apply_featurefile("/tmp/Gubbi_new.fea")
    font.close()
