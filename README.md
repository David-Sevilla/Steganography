

- Extract the content of this folder in a desired location of your computer
- Open MATLAB, add the content of this folder to MATLAB path
- Type StegoGUI on the Command Window to open the user interface


Three folders are provided:

	-Messages: Contains some square images that can be concealed using the LSB method.
			   This folder also contains some text messages samples.
			   
	-Images: Some sample images that can be used to conceal data
	
	-StegoImages: Contains some pictures with concealed messages. 
				  - Files ending in DCT_.jpg where consealed using DCT jsteg process and
					required a .key file to be decoded.
				  - Files ending in LSB_.bmp contain either text messages or images concealed 
					using the LSB method.
					
					
**NOTE: DCT (jsteg method) DOES NOT handle image concealing due to the restriction in storage capacity

For more information on how to opperate the GUI please refer to section 4 of the "Steganogragy: Concealing Data Within an Image", by David Sevilla.
(SevillaCazes_David_EECE5626_project_report.pdf)
	