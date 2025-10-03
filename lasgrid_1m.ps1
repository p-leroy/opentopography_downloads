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

$rootDir = "C:/DATA/000_Sophie_Rothman"
$inputDir = "C:/DATA/000_Sophie_Rothman/Downloads"
$outputDir = "C:/DATA/000_Sophie_Rothman/Downloads/out"

# Output in laz / 29 seconds for 100 laz
Measure-Command {
    lasgrid -i $inputDir/*.laz `
    -odir $outputDir `
    -olaz `
    -step 1 `
    -keep_class 4 5 `
    -cores 10
}

# Merge all laz
lasmerge -i $outputDir/*.laz -o $rootDir/merged.laz
