import sys
import fontforge

if __name__ == "__main__":
    font = fontforge.open("../Gubbi.sfd")
    
    # Remove all GSUB lookups
    for lookup in font.gsub_lookups:
        font.removeLookup(lookup)
        
    # Merge the new featurefile 
    font.mergeFeature("gsub.fea")
    font.save()
    font.close()
