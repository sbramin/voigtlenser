#!/bin/sh
exifTool=`which exiftool`

if [ $# -eq 0 ]
	  then
		      echo "No arguments supplied"
		      echo "Please input the path to a directory of DNG files"
		      echo "Eg. ./v.sh ~/Pictures/myPhotos"
		      exit
fi

for file in $1/*; do 
	  if [[ "$file" == *.DNG ]] 
		                then
	inputLens=`$exifTool -Lens $file`

	case $inputLens in

	  "Lens                            : Summicron-M 1:2/35 ASPH.")
		Lens="Voigtlander VM 35mm f/2 Ultron Aspherical"
	    ;;

	  "Lens                            : Summicron-APO-M 1:2/35 ASPH.")
		Lens="Voigtlander VM APO-LANTHAR 35mm F2 Aspherical"
	    ;;

	  "Lens                            : Summilux-M 1:1.4/35 ASPH.")
		Lens="Voigtlander VM 35mm f1.5 Nokton Aspherical II MC"
	    ;;

	  "Lens                            : Summicron-APO-M 1:2/50 ASPH.")
		Lens="Voigtlander VM APO-LANTHAR 50mm F2 Aspherical"
	    ;;

	  "Lens                            : Summilux-M 1:1.4/50 ASPH.")
		Lens="Voigtlander VM 50mm f1.5 Nokton Aspherical II MC"
	    ;;

	  *)
		echo "unknown lens detected: $inputLens"
		echo "exiting on file $file"
		exit
	    ;;
	esac

	LensProfileName="Adobe ($Lens)"

	$exifTool -LensProfileEnable=1 -LensProfileSetup=Custom -Lens="$Lens" -LensModel="$Lens" -LensID="" -LensMake="Voigtlander" -LensProfileName="$LensProfileName" -m -overwrite_original_in_place $file -v0
  else
	  echo "Skipping $file"
	  fi
done

