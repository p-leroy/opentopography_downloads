# Class 0: Never classified
# Class 1: Unclassified
# Class 2: Ground
# Class 3: Low Vegetation
# Class 4: Medium Vegetation
# Class 5: High Vegetation
# Class 6: Building
# Class 7: Low Point (low noise)
# Class 9: Water
# Class 17: Bridge Deck
# Class 18: High Noise

# Output in laz
lasgrid -i C:/DATA/000_Sophie_Rothman/Downloads/*.laz -step 1 -keep_class 3 4 5 -verbose -olaz -cores 5

# Output in tif
lasgrid -i C:/DATA/000_Sophie_Rothman/Downloads/*.laz -step 1 -keep_class 3 4 5 -verbose -otif -cores 5
