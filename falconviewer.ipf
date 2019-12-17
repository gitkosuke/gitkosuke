#pragma rtGlobals=3		// Use modern global access method.

#include <Autosize Images>

Menu "&Setting"
	"Do Panel Setting/1", /Q, PanelSetting()
	"Initial Folder/2", /Q, MakeInitialFolderPanel()
	"Movie Folder/3", /Q, MakeMovieFolderPanel()
	"PIC Folder/4", /Q, MakePICFolderPanel()
	//	"Movie/F9",  /Q,  ImageProcessing(2)
end

Menu "&Tracking and Flow Analysis"
	submenu "Covariance Tracking"
	      "Drift Compensation/5", /Q, MakeImageShiftPanel()
		"Single Molecule Tracking/6", /Q, MakeTrackingPanel()
		"Image Tracking/7", /Q, MakeWITrackingPanel()
	end
	"Linear Tracking/8",  /Q, MakeCellTrackingPanel()
	"Kymograph/9", /Q, MakeKymographPanel()
	//"Fixed Multi-Frame Correlation", /Q, MakeFixedMultiCorrPanel()
	//"Multi-Frame Correlation", /Q, MakeMultiCorrPanel()
	//	"Movie/F9",  /Q,  ImageProcessing(2)
end

Menu "&Analysis"
	"Binding",  /Q, MakeBindingAnalysisPanel()
	"Radius",  /Q,  MakeRadiusAnalysisPanel()
	"Statistics",  /Q,  MakeStatsPanel()
	"Image Slicer",  /Q,  MakeImageSlicerPanel()
	"Particle Volume", /Q, MakeParticleVPanel()
	//	"Kymograph/8", /Q, MakeKymographPanel()
	//"Fixed Multi-Frame Correlation", /Q, MakeFixedMultiCorrPanel()
	//"Multi-Frame Correlation", /Q, MakeMultiCorrPanel()
	//	"Movie/F9",  /Q,  ImageProcessing(2)
end


//Menu "&Averaging"

//	"Movie/F9",  /Q,  ImageProcessing(2)
//end

Menu "&3D View"
	"Show 3D Image", /Q, Show3DView()
	//	"Movie/F9",  /Q,  ImageProcessing(2)
end

Menu "&Edit"
	"Edit Panel", /Q, MakeEditPanel()
	"Image Interpolation Panel", /Q, MakeInterpolationPanel()
	//	"Movie/F9",  /Q,  ImageProcessing(2)
end


Menu "&Image Processing"
	"Line Profile/F3", /Q,MakeLineProfilePanel()
	submenu "Remove Background"
		"Auto/F4", /Q ,ImageProcessing(0)
		"Manual/F5", /Q,   ImageProcessing(1)
	end
	"Filter/F6",  /Q, ImageProcessing(2)
	"Frequency Filter/F7",  /Q, MakeFFTFilterPanel()
	"Magnify/F8", /Q, MakeMagnifyPanel()
	"Averaging/F9", /Q, MakeAveragingPanel()
	"Image Contrast/F10", /Q, CreateImageContrastGraph()
	"Colors/F11", /Q, MakeColorPanel()
	//	"Movie/F9",  /Q,  ImageProcessing(2)
end

//Menu "&Others"
	//"Particle Analysis", /Q, MakeParticles()
//	"Import Simulated Data", /Q, ImportSimData()
//	"Save Simulated Data", /Q, SaveSimImage()
	//"Linear Tracking/2",  /Q, MakeCellTrackingPanel()
	//	"Movie/F9",  /Q,  ImageProcessing(2)
//end


Menu "GraphMarquee"
	"Reset Size", /Q, ResetImageSize()
	"Fix Z Scale", /Q, FixScale(1)
	"Auto Z Scale", /Q, FixScale(0)
End




//Menu "Analysis"
//		"Tracking",MakeTrackingPanel()
//		"LinearTracking", LinearTracking()
//	//"bRVolume",     MakeBRVolumePanel()
//	//"bRTracking Ver.1",  BRTracking(1) //MakeBRTrackingPanel()
//	//"bRTracking",  MakeBRTrackingPanel()
//	//"AutobRTracking",  MakeAutoBRTrackingPanel()
//	//	"Image Averaging", MakeAveragingPanel()
//End


Function BRTracking(Mode)
	variable mode

	if(mode==1)

		Execute/P "DELETEINCLUDE \":Kanazawa:FalconViewer:bRTrackingAnalysis_Ver2\""
		Execute/P "INSERTINCLUDE \":Kanazawa:FalconViewer:bRTrackingAnalysis\""

		//MakeBRTrackingPanel()

		//�v���V�[�W���t�@�C��: "C:Program Files:WaveMetrics:Igor Pro Folder:AsylumResearch:Mad Temp:Menu.ipf"
		//	Execute/P "DELETEINCLUDE \":AsylumResearch:MADmode:Test:TestPanel\""
	endif
	if(mode==2)
		Execute/P "DELETEINCLUDE \":Kanazawa:FalconViewer:bRTrackingAnalysis\""
		Execute/P "INSERTINCLUDE \":Kanazawa:FalconViewer:bRTrackingAnalysis_Ver2\""

		//MakeBRTrackingPanel()

		//�v���V�[�W���t�@�C��: "C:Program Files:WaveMetrics:Igor Pro Folder:AsylumResearch:Mad Temp:Menu.ipf"
		//	Execute/P "DELETEINCLUDE \":AsylumResearch:MADmode:Test:TestPanel\""
	endif

end

Function CreateViewerVariables()

	// Make DataFolder

	string SavedDataFolder = GetDataFolder(1)

	string FullPath=SpecialDirPath("Igor Pro User Files", 0, 0, 0)

	PathInfo FalconViewerPath

	//print FullPath

	if(v_flag ==0)

		GetFileFolderInfo/D/Q FullPath+"User Procedures:FalconViewer"
//	\\Mac\Home\Documents\WaveMetrics\Igor Pro 6 User Files\User Procedures\FalconViewer
	endif


	NewPath/O/Q FalconViewerPath, S_Path

	SetDatafolder root:
	LoadData/Q/P=FalconViewerPath/O "ViewPanelParams.pxp" //Load PanelParams Waves


	/////////////////////////////



	Wave RemoveB
	if(WaveExists(RemoveB)==0)
		Make/N=4 RemoveB
		 RemoveB[0]=0
		 RemoveB[1]=10
		 RemoveB[2]=20
		RemoveB[3]=20
	endif

	Wave RemoveBM
	if(WaveExists(RemoveBM)==0)
		Make/N=4  RemoveBM
		 RemoveBM[0]=0
		 RemoveBM[1]=10
		 RemoveBM[2]=20
		RemoveBM[3]=20
	endif

//	Wave Freq
//	if(WaveExists(Freq)==0)
//		Make/N=4  Freq
//		 Freq[0]=0
//		 Freq[1]=10
//		 Freq[2]=20
//		 Freq[3]=20
//	endif

	Wave FreqFilterP
	if(WaveExists(FreqFilterP)==0)
		Make/N=4  FreqFilterP
		 FreqFilterP[0]=0
		 FreqFilterP[1]=10
		 FreqFilterP[2]=20
		 FreqFilterP[3]=20
	endif

	Wave Line
	if(WaveExists(Line)==0)
		Make/N=4  Line
		 Line[0]=0
		 Line[1]=10
		 Line[2]=20
		 Line[3]=20
	endif

	Wave MainViewP
	if(WaveExists(MainViewP)==0)
		Make/N=4  MainViewP
		MainViewP[0]=0
		MainViewP[1]=10
		MainViewP[2]=20
		MainViewP[3]=20
	endif

	Wave ForceRP
	if(WaveExists(ForceRP)==0)
		Make/N=4  ForceRP
		ForceRP[0]=0
		ForceRP[1]=10
		ForceRP[2]=20
		ForceRP[3]=20
	endif

	Wave TrackP
	if(WaveExists(TrackP)==0)
		Make/N=4  TrackP
		TrackP[0]=0
		TrackP[1]=10
		TrackP[2]=20
		TrackP[3]=20
	endif

	Wave WITrackP
	if(WaveExists(WITrackP)==0)
		Make/N=4  WITrackP
		WITrackP[0]=0
		WITrackP[1]=10
		WITrackP[2]=20
		WITrackP[3]=20
	endif

	Wave AveP
	if(WaveExists(AveP)==0)
		Make/N=4  AveP
		AveP[0]=0
		AveP[1]=10
		AveP[2]=20
		AveP[3]=20
	endif

	Wave GizmoP
	if(WaveExists(GizmoP)==0)
		Make/N=4  GizmoP
		GizmoP[0]=0
		GizmoP[1]=10
		GizmoP[2]=20
		GizmoP[3]=20
	endif

	Wave GizmoSettingP
	if(WaveExists(GizmoSettingP)==0)
		Make/N=4  GizmoSettingP
		GizmoSettingP[0]=0
		GizmoSettingP[1]=10
		GizmoSettingP[2]=20
		GizmoSettingP[3]=20
	endif

	Wave InitialFolderP
	if(WaveExists(InitialFolderP)==0)
		Make/N=4  InitialFolderP
		InitialFolderP[0]=0
		InitialFolderP[1]=10
		InitialFolderP[2]=20
		InitialFolderP[3]=20
	endif

	Wave MovieFolderP
	if(WaveExists(MovieFolderP)==0)
		Make/N=4  MovieFolderP
		MovieFolderP[0]=0
		MovieFolderP[1]=10
		MovieFolderP[2]=20
		MovieFolderP[3]=20
	endif

	Wave EditP
	if(WaveExists(EditP)==0)
		Make/N=4  EditP
		EditP[0]=0
		EditP[1]=10
		EditP[2]=20
		EditP[3]=20
	endif

	Wave MainSaveP
	if(WaveExists(MainSaveP)==0)
		Make/N=4  MainSaveP
		MainSaveP[0]=0
		MainSaveP[1]=10
		MainSaveP[2]=20
		MainSaveP[3]=20
	endif

	Wave DwellP
	if(WaveExists(DwellP)==0)
		Make/N=4  DwellP
		 DwellP[0]=0
		 DwellP[1]=10
		 DwellP[2]=20
		 DwellP[3]=20
	endif


	Wave ImageRangeP
	if(WaveExists(ImageRangeP)==0)
		Make/N=4   ImageRangeP
		ImageRangeP[0]=0
		ImageRangeP[1]=10
		ImageRangeP[2]=20
		ImageRangeP[3]=20
	endif

	Wave SimuP
	if(WaveExists(SimuP)==0)
		Make/N=4   SimuP
		SimuP[0]=0
		SimuP[1]=10
		SimuP[2]=20
		SimuP[3]=20
	endif

	Wave MagnifyP
	if(WaveExists(MagnifyP)==0)
		Make/N=4   MagnifyP
		MagnifyP[0]=0
		MagnifyP[1]=10
		MagnifyP[2]=20
		MagnifyP[3]=20
	endif

	Wave StatsP
	if(WaveExists(StatsP)==0)
		Make/N=4   StatsP
		StatsP[0]=0
		StatsP[1]=10
		StatsP[2]=20
		StatsP[3]=20
	endif

	Wave AveP
	if(WaveExists(AveP)==0)
		Make/N=4   AveP
		AveP[0]=0
		AveP[1]=10
		AveP[2]=20
		AveP[3]=20
	endif

	Wave ImageShiftP
	if(WaveExists(ImageShiftP)==0)
		Make/N=4   ImageShiftP
		ImageShiftP[0]=0
		ImageShiftP[1]=10
		ImageShiftP[2]=20
		ImageShiftP[3]=20
	endif

	Wave SlicerP
	if(WaveExists(SlicerP)==0)
		Make/N=4  SlicerP
		SlicerP[0]=0
		SlicerP[1]=10
		SlicerP[2]=20
		SlicerP[3]=20
	endif

	Wave InterpolationP
	if(WaveExists(InterpolationP)==0)
		Make/N=4  InterpolationP
		InterpolationP[0]=0
		InterpolationP[1]=10
		InterpolationP[2]=20
		InterpolationP[3]=20
	endif


	Wave MovieConfigP
	if(WaveExists(MovieConfigP)==0)
		Make/N=4  MovieConfigP
		MovieConfigP[0]=0
		MovieConfigP[1]=10
		MovieConfigP[2]=20
		MovieConfigP[3]=20
	endif




	///////////////////


	// KillDataFolder/Z  root:ViewVariables
	//  SavedDataFolder=GetData

	if(DataFolderExists("root:ViewVariables"))

		KillDataFolder/Z root:ViewVariable
	endif

	NewDataFolder/O/S  root:ViewVariables
	KillWaves/A/Z

	//Make Waves

	Make/T/O/N=0 textOutputWave
	//Make/O/T ImageList
	//Make/O ImageListBuddy
	BlueRedColorIndexWave()

	//Make/O/N=(256,256) DisplayImage

	//Make Variables


	variable/G XPixel
	variable/G YPixel
	variable/G FrameTime
	variable/G XScanSize
	variable/G YScanSize
	variable/G MaxData
	variable/G MiniData
	variable/G ImageIndex
	variable/G ImageTotalNum
	variable/G Year, Month, Day, Hour, Minute, Second
	variable/G Show2chFlag
	variable/G LaserFlag
	variable/G CurrentNum
	variable/G XTilt, YTilt
	variable/G XOffset, YOffset
	variable/G FileType
	variable/G MaxData2ch
	variable/G FileHeaderSize
	variable/G FrameHeaderSize
	variable/G TextEncoding
	variable/G OpeNameSize
	variable/G CommentSize
	variable/G FrameNum
	variable/G ImageNum
	variable/G AveFlag
	variable/G AverageNum
	variable/G XRound, YRound
	variable/G Sensitivity, PhaseSens
	variable/G MachineNo
	variable/G MaxScanSizeX, MaxScanSizeY
	variable/G PiezoConstX, PiezoConstY, PiezoConstZ
	variable/G DriverGainZ
	variable/G ScanDirection
	variable/G DataType1ch,  DataType2ch
	variable/G ScanTryNum
	variable/G ADResolution
	variable/G ADRange
	variable/G ViewNum
	variable/G ImageFileIndex
	variable/G  FileNum
	variable/G TabMode
	variable/G CrossFilterFlag=0
	variable/G CrossFilterLevel=1
	variable/G  CrossFilterNum=1
	variable/G Max_Scale, Min_Scale
	variable/G ScaleMode
	variable/G ScaleModeFlag=0
	variable/G AutoViewAll
	variable/G DataVer
	variable/G FirstFileforASD, LastFileforASD
	variable/G AutoViewStatus
	variable/G CommentOffset
	variable/G Offset
	variable/G OldImageFileIndex
	variable/G AutoViewSpeed
	variable/G ScaleMode=0
	variable/G ContinMode=1
	variable/G CheckShowCBar=1

	variable/G percentFinished=0
	variable/G MovieSize=1
	variable/G MovieChannel=1

	variable/G lastRunTicks

	variable/G SliderPos1, SliderPos2
	variable/G SliderSetFlag=0
	variable/G RangeLeft, RangeTop, RangeWidth, RangeHeight

	variable/G OldYPixel

	variable/G OldXSize
	variable/G OldYSize


	variable/G CheckSubFolder=0

	variable/G RangeMode=0

	variable/G invert=0

	variable/G  CheckSwapChFlag=0


	//FileSaveVAriables
	variable/G SaveBMPFlag=0
	variable/G SaveASDFlag=0
	variable/G  SaveJPegFlag=1
	variable/G  SaveTIFFFlag=0
	variable/G SaveBCRFlag=0
	variable/G SaveImageResNum=1
	variable/G SaveImageRes=500
	variable/G SaveModeFlag=2
	variable/G SaveFlag=0
	variable/G FirstFrame
	variable/G LastFrame
	variable/G InfoFlag=0
	variable/G TimeFlag=0
	variable/G TimeCap_Unit=2
	variable/G TimeCap_Start=0
	variable/G TimeCap_Size=18
	variable/G TimeCap_Color=1
	variable/G  TimeCap_Font=1
	variable/G TimeCap_Pos=1
	variable/G TimeCap_Style=2
	variable/G TimeCap_Rounding=1
	//variable/G Movie_Type=1

	variable/G Check3DSave=0

	variable/G RecordedIndex=0

	variable/G ScaleFlag=0
	variable/G ScaleBar_unit=1
	variable/G ScaleBar_Length=20
	variable/G ScaleBar_Thickness=2
	variable/G ScaleBar_LPosi=5
	variable/G ScaleBar_TPosi=90


	variable/G ScaleCap_LPosi=0
	variable/G ScaleCap_TPosi=10
	variable/G  ScaleCap_Font=10
	variable/G  CheckShowRange=0

	String/G FileNameCap
	variable/G FileNameFlag=0
	variable/G FileNameCap_Size=15
	variable/G FileNameCap_LPosi=30
	variable/G FileNameCap_TPosi=30
	//String/G ScaleCap_Style


	///

	//Make Strings
	String/G Path
	String/G FileName=""
	String/G OpeName=""
	String/G Comment=""
	String/G ImageFilePath=""
	String/G CapturedDate=""
	String/G BaseName=""
	String/G Suffix=""
	String/G FileName2ch
	String/G FilePath2ch
	String/G PopUpItems
	String/G TextDisplayStringPath
	String/G TextDisplayStringComment=""

	String/G SaveFilePath
	String/G SaveFileName

	String/G InitialFolder
	String/G MovieFolder
	String/G PICFolder
	variable/G FileOpenCheck=0


	//////// Edit
	variable/G CommentEdit_Tag=0
	variable/G TrimEdit_Tag=0
	variable/G ClipEdit_Tag=0
	variable/G DivideEdit_Tag=0
	variable/G ConcEdit_Tag=0
	variable/G CheckShowKilledFile=0

	///2018/9/27 Movie
	variable/G FrameRate
	variable/G CompFactor=0
	variable/G MovieFormat=1
	//


	//Wave myColors=root:ViewVariables:myColors
	//Wave myColors2ch=root:ViewVariables:myColors2ch

	////Duplicate/O myColors myColorsLinear
	//Duplicate/O myColors2ch myColorsLinear2ch


	DoWIndow MainViewPanel

	if(V_flag !=0)

		DoWindow/K MainViewPanel
	endif

	SetDatafolder root:ViewVariables
	LoadData/Q/P=FalconViewerPath/O "ViewParams.pxp" //Load PanelParams Waves

	String/G ViewPanelCtrlList

	String/G SavePanelCtrlList


	SetDataFolder SavedDataFolder

End


Function CreateImageProssVariables()
	string SavedDataFolder = GetDataFolder(1)

	//DataFolder

	if(DataFolderExists(" root:ImageProcessVariables"))

		KillDataFolder root:ImageProcessVariables
	endif

	NewDataFolder/O/S  root:ImageProcessVariables


	//Variables
	variable/G CheckRemoveBG1ch
	variable/G CheckRemoveBG2ch

	// 2016/9/15
	variable/G CheckOffFlatten1ch
	variable/G CheckOffFlatten2ch
	variable/G CheckMedianFlatten1ch
	variable/G CheckMedianFlatten2ch
	variable/G CheckMedianDifFlatten1ch
	variable/G CheckMedianDifFlatten2ch
	variable/G CheckMeanFlatten1ch
	variable/G CheckMeanFlatten2ch
	//



	variable/G SetRemoveOrder1ch
	variable/G SetRemoveOrder2ch
	variable/G CheckRemoveLineBG1ch
	variable/G CheckRemoveLineBG2ch
	variable/G SetRemoveLineOrder1ch
	variable/G SetRemoveLineOrder2ch

	variable/G PopFlattenDirection1ch
	variable/G PopFlattenDirection2ch

	String/G SFlattenDirection1ch
	String/G SFlattenDirection2ch




	variable/G  ManualRBGDirection
	variable/G  ManualRBGPosition
	variable/G  ManualRBGAngle
	variable/G  CheckManualRBG

	variable/G CheckAllFilter1ch
	variable/G  CheckAllFilter2ch
	variable/G SetFilterNum1ch
	variable/G SetFilterNum2ch


	///2016/9/16
	variable/G CheckRemoveScars1ch
	variable/G CheckRemoveScars2ch
	variable/G ScarsLength1ch
	variable/G ScarsLength2ch


	/////



	/////

	variable/G CheckFFT_Flag

	//variable/G MovieSpeed
	//variable/G CheckMovie2ch

	String/G SetFilterType1ch
	String/G SetFilterType2ch

	Variable/G Process=0
	Variable/G SizeChanged=0

	Variable/G CheckImageContrast=0


	CheckRemoveBG1ch=0
	CheckRemoveBG2ch=0
	SetRemoveOrder1ch=1
	SetRemoveOrder2ch=1
	CheckRemoveLineBG1ch=0
	CheckRemoveLineBG2ch=0
	SetRemoveLineOrder1ch=1
	SetRemoveLineOrder2ch=1


	CheckOffFlatten1ch=1
	CheckOffFlatten2ch=1
	CheckMedianFlatten1ch=0
	CheckMedianFlatten2ch=0
	CheckMedianDifFlatten1ch=0
	CheckMedianDifFlatten2ch=0
	CheckMeanFlatten1ch=0
	CheckMeanFlatten2ch=0


	SFlattenDirection1ch="Horizontal"
	SFlattenDirection2ch="Horizontal"

	PopFlattenDirection1ch=1
	PopFlattenDirection2ch=1



	ManualRBGDirection=1
	ManualRBGAngle=0
	CheckManualRBG=0


	CheckAllFilter1ch=0
	CheckAllFilter2ch=0
	SetFilterNum1ch=1
	SetFilterNum2ch=1

	CheckRemoveScars1ch=0
	CheckRemoveScars2ch=0
	ScarsLength1ch=3
	ScarsLength1ch=3

	CheckFFT_Flag=0

	//MovieSpeed=1
	//CheckMovie2ch=0

	SetFilterType1ch="avg"
	SetFilterType2ch="avg"


	SetDataFolder SavedDataFolder


End

Function MakeViewPanel(mode)
	variable mode

	variable firstLineNum
	string SavedDataFolder = GetDataFolder(1)

	DoWIndow MainViewPanel

	if(V_Flag==0)
		//CreateViewerVariables()
		//CreateImagProssVariables()
	endif

	if(DataFolderExists("root:ViewVariables") !=1)
		CreateViewerVariables()
		CreateImageProssVariables()

	endif

	// HideIgorMenus

	SetDatafolder root:ViewVariables



	Variable Width, Height, Top, ScreenNUm
	variable CurrentTop, CurrentLeft, CtrlSpace
	variable show

	NVAR XPixel
	NVAR YPixel
	NVAR FrameTime
	NVAR XScanSize
	NVAR YScanSize
	NVAR MaxData
	NVAR ImageIndex
	NVAR ImageTotalNum
	NVAR Year, Month, Day, Hour, Minute, Second
	NVAR Show2chFlag
	NVAR AutoViewSpeed
	NVAR FrameNum
	NVAR ScaleMode
	NVAR ContinMode
	NVAR FileOpenCheck
	NVAR CheckShowCBar

	NVAR  CrossFilterFlag

	NVAR Tabmode


	SVAR CapturedDate
	SVAR ImageFilePath
	SVAR Comment
	SVAR OpeName
	SVAR TextDisplayStringPath
	SVAR TextDisplayStringComment

	NVAR AutoViewStatus

	NVAR CheckSubFolder

	NVAR RangeMode

	NVAR Invert

	NVAR CheckSwapChFlag


	AutoViewStatus=0

	Wave  MainViewPanelParams=root:MainViewP
	Wave  MainSavePanelParams=root:MainSaveP

	if(mode==0) //Imaging mode�����������ꍇ


		OpeName=""
		Comment=""
		ImageIndex=0
		ImageTotalNum=0


		//SetDataFolder root:ViewVariables

		DoWindow MainViewPanel


		if(V_Flag==0)

			PauseUpdate; Silent 1
			NewPanel/K=2 as "Main View Panel"
			DoWindow/C/T MainViewPanel, "Main View Panel"			//name and title the panel
			SetWindow MainViewPanel, hook=KillViewWinPanel

			MoveWindow/W=MainViewPanel 10, 400, 700, 600


			TabControl  AnalyzeTab pos={10,5},size={100,20}, win=MainViewPanel
			TabControl AnalyzeTab tabLabel(0)="View",tabLabel(1)="Save", win=MainViewPanel, proc=PreTabProc //,tabLabel(2)="Histogram"//,mode=(tab+1)

			XPixel=0
			YPixel=0
			FrameTime=0
			XScanSize=0
			YScanSize=0
			MaxData=0
			ImageIndex=0
			ImageTotalNum=0

			FileOpenCheck=0

			CheckSubFolder=1


			CurrentTop=30
			CurrentLeft=10
			CtrlSpace=18


			Comment=""

			CapturedDate=num2Str(Year)+"/"+num2str(Month)+"/"+num2str(Day)+"  "+num2Str(Hour)+":"+num2str(Minute)+":"+num2Str(Second)
			TitleBox TitleBoxCapturedDate, win=MainViewPanel, pos={CurrentLeft,CurrentTop}, frame=0, variable=CapturedDate //size={240,100}

			CurrentTop +=CtrlSpace
			ValDisplay ShowXPixel,win=MainViewPanel, pos={CurrentLeft,CurrentTop},size={130,35},frame=0,title="X pixel : "
			ValDisplay ShowXPixel,win=MainViewPanel, value= #"root:ViewVariables:XPixel"

			CurrentTop +=CtrlSpace
			ValDisplay ShowYPixel,win=MainViewPanel, pos={CurrentLeft,CurrentTop},frame=0,size={130,15},title="Y pixel : "
			ValDisplay ShowYPixel,win=MainViewPanel, value= #"root:ViewVariables:YPixel"

			CurrentTop +=CtrlSpace
			ValDisplay ShowXScanSize,win=MainViewPanel, pos={CurrentLeft,CurrentTop},frame=0,size={160,15},title="X Scan Size : "
			ValDisplay ShowXScanSize,win=MainViewPanel, format="%.2fnm",value= #"root:ViewVariables:XScanSize"

			CurrentTop +=CtrlSpace
			ValDisplay ShowYScanSize,win=MainViewPanel, pos={CurrentLeft,CurrentTop},frame=0,size={160,15},title="Y Scan Size : "
			ValDisplay ShowYScanSize,win=MainViewPanel, format="%.2fnm",value= #"root:ViewVariables:YScanSize"

			CurrentTop +=CtrlSpace
			ValDisplay ShowFrameTime,win=MainViewPanel, pos={CurrentLeft,CurrentTop},frame=0,size={160,15},title="Frame Time : "
			ValDisplay ShowFrameTime,win=MainViewPanel, format="%.2fms",value= #"root:ViewVariables:FrameTime"

			CurrentTop +=CtrlSpace
			ValDisplay ShowLaserFlag,pos={CurrentLeft,CurrentTop},size={130,10},frame=0, title="Laser :  "
			ValDisplay ShowLaserFlag,value= #"root:ViewVariables:LAserFlag"

			CurrentTop +=CtrlSpace
			TitleBox ShowOpeNameTitle,win=MainViewPanel,  pos={CurrentLeft,CurrentTop},size={50,100},frame=0,Title="Operator : "
			TitleBox ShowOpeName,win=MainViewPanel,  pos={CurrentLeft+55,CurrentTop},size={50,100},frame=0, variable=OpeName

			CurrentTop +=CtrlSpace
			CheckBox ColorBarCheck,win=MainViewPanel,  pos={CurrentLeft+5,CurrentTop+5}, title="Show Color Bar", variable=CheckShowCBar, proc=CheckShowCBarProc


			CurrentTop +=CtrlSpace
			Button buttonSelectFolder,win=MainViewPanel, pos={CurrentLeft,CurrentTop+10},size={100,32},disable=0,proc=ButtonSelectFolder,title="Select Folder"
			Button buttonSelectFolder,win=MainViewPanel,help={"Click to select an open folder."}

			CurrentTop +=25
			CheckBox SubFolderCheck,win=MainViewPanel,  pos={CurrentLeft+5,CurrentTop+23}, title="Subfolder", variable=CheckSubFolder//, proc=Check2chShowProc

			//CurrentTop -=25

			CheckBox InvertCheck,win=MainViewPanel,  pos={CurrentLeft+110,CurrentTop}, title="Invert", variable=Invert , proc=CheckInvertProc

			CheckBox Show2chCheck,win=MainViewPanel,  pos={CurrentLeft+110,CurrentTop+23}, title="Show 2ch", variable=Show2chFlag, proc=Check2chShowProc

			//if(Show2chFlag==1)
				CheckBox SwapChCheck,win=MainViewPanel,  pos={CurrentLeft+110,CurrentTop+46}, disable=1, title="Swap Channels", variable=CheckSwapChFlag, proc=CheckSwapChProc
			//else
			//	CheckBox SwapChCheck,win=MainViewPanel,  pos={CurrentLeft+110,CurrentTop+46}, disable=1, title="Swap Channels", variable=CheckSwapChFlag, proc=CheckSwapChProc
			//endif

			CurrentLeft +=200
			CurrentTop =10


			Wave/T TextOutputWave

			TitleBox ShowDataFolder,win=MainViewPanel,  pos={CurrentLeft,CurrentTop},size={200,100},frame=0, fsize=6, variable=textDisplayStringPath
			//GroupBox groupDataFolder win=MainViewPanel, pos={CurrentLeft,CurrentTop}, size={300,43}, disable=1

			textDisplayStringPath = WordWrapControlText(ImageFilePath, textOutputWave, "MainViewPanel", "ShowDataFolder", "groupDataFolder", firstLineNum = 0)

			CurrentTop +=CtrlSpace
			ListBox ImageList,win=MainViewPanel, font="Arial", fsize=6,frame=2,mode=4,selWave=root:ViewVariables:ImageListBuddy
			ListBox ImageList,win=MainViewPanel, pos={CurrentLeft,CurrentTop+20},listWave=root:ViewVariables:ImageList,size={250,150}, proc=ImageDisplayListFuncAction


			CurrentTop +=CtrlSpace+135


			ImageIndex=0
			SetVariable SetIndex,win=MainViewPanel, pos={CurrentLeft,CurrentTop+20},frame=1,size={80,10}, title="Index :"
			SetVariable SetIndex,win=MainViewPanel,  limits={0, 0,1},value=$"root:ViewVariables:ImageIndex", proc=SetIndexProc


			//SetVariable SetIndex,limits={0,0,1},value= root:'_killed folder_':ImageIndex

			//ValDisplay ShowIndex,pos={30,580},frame=0,size={80,10}, title="Index :"
			//ValDisplay ShowIndex,value= #"root:ViewVariables:ImageIndex"

			ValDisplay ShowTotalNum,win=MainViewPanel, pos={CurrentLeft+115,CurrentTop+20},frame=0, size={130,10},title="Total Number :"
			ValDisplay ShowTotalNum,win=MainViewPanel, value= #"root:ViewVariables:FrameNum"


			CurrentTop +=CtrlSpace

			Slider ImageSlider win=MainViewPanel, pos={CurrentLeft,CurrentTop+25},size={250,53 }, ticks=0, vert=0


			Button buttonSetImage,win=MainViewPanel, pos={CurrentLeft+265,CurrentTop+25},size={30,20},disable=2,title="Set",proc=ButtonSetImageProc
			Button buttonSetImage,win=MainViewPanel,help={"Left click: set the first and the last frames Right click: reset the selected frames."}

			CheckBox ContinModeCheck,win=MainViewPanel,  pos={CurrentLeft+320,CurrentTop+30}, title="Continuos mode", variable=ContinMode

			ValDisplay ShowFirstFrame,win=MainViewPanel, pos={CurrentLeft+150,CurrentTop+40},frame=0, size={60,10},title="From"
			ValDisplay ShowFirstFrame,win=MainViewPanel, value= #"root:ViewVariables:FirstFrame", valueBackColor=(61000,61000,61000 )

			ValDisplay ShowLastFrame,win=MainViewPanel, pos={CurrentLeft+210,CurrentTop+40},frame=0, size={60,10},title="to"
			ValDisplay ShowLastFrame,win=MainViewPanel, value= #"root:ViewVariables:LastFrame", valueBackColor=(61000,61000,61000 )


			CurrentLeft +=280
			CurrentTop=10


			//TitleBox ShowComment, win=MainViewPanel, pos={CurrentLeft+5,CurrentTop+20},size={250,123},frame=0, disable=0, variable=textDisplayStringComment
			//GroupBox CommentGroup, win=MainViewPanel, pos={CurrentLeft,CurrentTop}, size={250,123}, title="Comment", disable=0
			TitleBox ShowComment, win=MainViewPanel, pos={CurrentLeft+5,CurrentTop},size={250,123},frame=0, disable=0,Title="Comment"
			NewNotebook /F=1 /N=CommentNote /HOST=MainViewPanel /W=(CurrentLeft+5,CurrentTop+15,CurrentLeft+5+280,CurrentTop+123)/OPTS=4 as "CommentNote"
			SVAR Comment=root:ViewVariables:Comment
			NoteBook MainViewPanel#CommentNote text=Comment

			CurrentTop +=140



			CheckBox ShowCrossFilterCheck, win=MainViewPanel, pos={CurrentLeft,CurrentTop}, title="Cross Filter", variable=CrossFilterFlag , proc=CheckCrossFilterProc

			if(CrossFilterFlag==1)
				Show=0
			else
				Show=1
			Endif

			CurrentTop +=18
			CurrentLeft+=5
			SetVariable setvarLevel,win=MainViewPanel, pos={CurrentLeft,CurrentTop},size={80,15},title="Level:"
			SetVariable setvarLevel,win=MainViewPanel,  limits={1, inf,1},value=$"root:ViewVariables:CrossFilterLevel",disable=1, proc=SetCrossFilterLevelProc

			CurrentTop +=20
			SetVariable setvarNum,win=MainViewPanel, pos={CurrentLeft,CurrentTop},size={80,15},title="Num:"
			SetVariable setvarNum,win=MainViewPanel,  limits={1, inf,1},value=$"root:ViewVariables:CrossFilterNum",disable=1, proc=SetCrossFilterNumProc


			CurrentTop -=(20+18)
			CurrentLeft+=130

			Button buttonAutoView,win=MainViewPanel, pos={CurrentLeft,CurrentTop},size={20,22},disable=0,proc=ButtonAutoView,title="�t�t"

			CurrentTop+=5
			CurrentLeft+=30
			CheckBox CheckAutoViewAll,win=MainViewPanel,  pos={CurrentLeft,CurrentTop}, title="All", variable=AutoViewAll

			AutoViewSpeed=1
			CurrentTop+=18
			Slider AutoViewSlider win=MainViewPanel, pos={CurrentLeft,CurrentTop},size={132,53 } ,ticks=1,vert=0, live=0,limits= {1,30,1},variable= AutoViewSpeed



			CurrentTop+=4
			CurrentLeft+=138
			SetVariable SetAutoViewSpeed, win=MainViewPanel, pos={CurrentLeft,CurrentTop},frame=1,size={30,10}, title=" ", value=$"root:ViewVariables:AutoViewSpeed"
			//	SetVariable SetAutoViewSpeed,  limits={1, 30,1},




			ScaleMode=0
			CurrentTop+=48
			CurrentLeft-=130
			PopupMenu popupScaleMode,win=MainViewPanel, mode=1,title="Scale",pos={CurrentLeft,CurrentTop},popvalue="Auto",value= #"\"Auto;Manual\"",proc=PopScaleModeProc


			RangeMode=0
			PopupMenu popupRangeMode,win=MainViewPanel, mode=1,title="Range",disable=2, pos={CurrentLeft+100,CurrentTop},popvalue="None",value= #"\"None;MaxZ;MinZ;MaxHist\"",proc=PopRangeModeProc



			DoWindow Image1ch

			if(V_Flag==1)
				DoWindow/k Image1ch
			endif

			DoWindow Image2ch
			if(V_Flag==1)
				DoWindow/k Image2ch
			endif


			/////// Save Mode Controls //////
			CurrentTop =50
			CurrentLeft=30
			NVAR SaveBMPFlag
			CheckBox SaveBMP, win=MainViewPanel, pos={CurrentLeft, CurrentTop}, title="BMP", variable=SaveBMPFlag, disable=1

			CurrentTop +=30
			NVAR SaveTIFFFlag
			CheckBox SaveTIFF,win=MainViewPanel,  pos={CurrentLeft, CurrentTop}, title="TIFF", variable=SaveTIFFFlag, disable=1

			CurrentTop +=30
			NVAR SaveASDFlag
			CheckBox SaveASD, win=MainViewPanel, pos={CurrentLeft, CurrentTop}, title="ASD", variable=SaveASDFlag, proc=CheckSaveASDProc, disable=1


			CurrentTop =50
			CurrentLeft +=90
			NVAR SaveJPegFlag
			CheckBox SaveJPEG, win=MainViewPanel, pos={CurrentLeft, CurrentTop}, title="JPEG", variable=SaveJPEGFlag, disable=1

			CurrentTop +=60
			NVAR SaveBCRFlag
			CheckBox SaveBCR,win=MainViewPanel,  pos={CurrentLeft, CurrentTop}, title="BCR", variable=SaveBCRFlag, disable=1


			CurrentTop =70
			CurrentLeft +=60

			NVAR SaveImageResNum
			PopupMenu popupRes,win=MainViewPanel, pos={CurrentLeft, CurrentTop},size={50,20},title="Resolutin(DPI)", win=MainViewPanel
			PopupMenu popupRes, win=MainViewPanel, mode=SaveImageResNum,value= #"\"500;300;200;150;100\"",win=MainViewPanel, proc=PopSaveImageRes, disable=1


			CurrentTop =150
			CurrentLeft =30

			NVAR SaveModeFlag
			PopupMenu popupSaveModeFlag,win=MainViewPanel, pos={CurrentLeft, CurrentTop},title="Mode", win=MainViewPanel, size={180,30}
			PopupMenu popupSaveModeFlag, win=MainViewPanel, mode=SaveModeFlag,value= #"\"Single File;Limited Frames\"",win=MainViewPanel , proc=PopSaveModeMenuProc, disable=1

			variable disableStatus=1
			if(SaveModeFlag==2)
				disableStatus=0
			endif

			//NVAR Movie_Type

			CurrentLeft +=150
			//PopupMenu popupMovieType,win=MainViewPanel, pos={CurrentLeft, CurrentTop},title="Movie Type", win=MainViewPanel, size={180,30}
			//PopupMenu popupMovieType,win=MainViewPanel,  mode=Movie_Type,value= #"\"MOV;AVI\"",win=MainViewPanel , proc=PopMovieTypeProc, disable=1



			NVAR MovieSize

			//CurrentTop +=40
			SetVariable SetMovieSize,win=MainViewPanel, pos={CurrentLeft, CurrentTop-8},frame=1,size={80,10}, title="Size:", disable=0
			SetVariable SetMovieSize,win=MainViewPanel,  limits={0.1,10,0.1},value=$"root:ViewVariables:MovieSize", proc= SetMovieSizeProc, disable=1


			NVAR CheckShowRange
			CurrentTop +=30
			CheckBox CheckShowRange, win=MainViewPanel, pos={CurrentLeft,CurrentTop}, title="Show Scan Range", variable=CheckShowRange , proc=CheckShowRangeProc, disable=1



			CurrentLeft -=150
			//CurrentTop -=20
			//CurrentLeft +=150

			NVAR FirstFrame

			SetVariable SetStartIndex,win=MainViewPanel, pos={CurrentLeft, CurrentTop},frame=1,size={80,10}, title="First :"
			SetVariable SetStartIndex, win=MainViewPanel, limits={0, FrameNum-1,1},value=$"root:ViewVariables:FirstFrame", disable=1// , proc= SetSaveStartIndexVarProc


			NVAR LastFrame

			CurrentTop+=10
			SetVariable SetEndIndex,win=MainViewPanel, pos={CurrentLeft, CurrentTop+9},frame=1,size={80,10}, title="Last :"
			SetVariable SetEndIndex,win=MainViewPanel,  limits={0, FrameNum-1,1},value=$"root:ViewVariables:LastFrame", disable=1// , proc=SetSaveEndIndexVarProc

			CurrentTop+=35
			NVAR Check3DSave
			CheckBox CheckSave3D, win=MainViewPanel, pos={CurrentLeft, CurrentTop}, title="3D view", variable=Check3DSave,  proc=Check3DSaveProc, disable=1


			CurrentTop+=15

			Button buttonSaveImages,win=MainViewPanel, pos={CurrentLeft, CurrentTop+9},size={100,32},title="Save", Proc=ButtonSaveProc, disable=1


			//CurrentTop =200
			CurrentLeft +=125

			Button buttonMakeMovie,win=MainViewPanel, pos={CurrentLeft, CurrentTop+9},size={100,32},title="Make Movie", Proc=ButtonMakeMovieCheckProc, disable=1



			CurrentTop =206
			//////////// Caption

			NVAR  TimeFlag
			NVAR  TimeCap_Unit
			NVAR  TimeCap_Start
			NVAR  TimeCap_Size
			NVAR  TimeCap_Color
			NVAR   TimeCap_Font
			NVAR   TimeCap_Style
			NVAR  TimeCap_Pos
			NVAR TimeCap_Rounding


			CurrentTop =20
			CurrentLeft =400

			GroupBox groupTimeCap,pos={ CurrentLeft,CurrentTop},size={155,295},title="Time", fstyle=1, disable=1

			//TimeFlag=0

			CurrentTop +=20
			CurrentLeft +=15
			CheckBox CheckTimeCaption, win=MainViewPanel, pos={CurrentLeft,CurrentTop}, title="Add", variable=TimeFlag , proc=CheckAddTime, disable=1


			CurrentTop +=25
			PopupMenu popupTimeCapUnit,win=MainViewPanel, pos={CurrentLeft,CurrentTop}, size={71,20},title="Unit"
			PopupMenu popupTimeCapUnit,win=MainViewPanel,  mode=TimeCap_Unit,value= #"\"ms;s;min\"",proc=PopTimeCapUnitProc, disable=1

			CurrentTop +=25
			PopupMenu popupTimeCapRounding,win=MainViewPanel, pos={CurrentLeft,CurrentTop}, size={71,20},title="Rounding"
			PopupMenu popupTimeCapRounding,win=MainViewPanel,  mode=TimeCap_Rounding,value= #"\"raw;round;ceil;floor\"",proc=PopTimeCapRoundingProc, disable=1


			CurrentTop +=25
			if(TimeCap_Unit==1)
				SetVariable setvarTimeStart,win=MainViewPanel, pos={CurrentLeft,CurrentTop},size={122,24},title="Start time", value=TimeCap_Start, format="%.2fms", proc=SetTimeCapStartProc, disable=1
			elseif(TimeCap_Unit==2)
				SetVariable setvarTimeStart,win=MainViewPanel,  pos={CurrentLeft,CurrentTop},size={122,24},title="Start time", value=TimeCap_Start, format="%.2fs", proc=SetTimeCapStartProc, disable=1
			elseif(TimeCap_Unit==3)
				SetVariable setvarTimeStart,win=MainViewPanel,  pos={CurrentLeft,CurrentTop},size={122,24},title="Start time", value=TimeCap_Start, format="%.2fmin", proc=SetTimeCapStartProc, disable=1
			endif


			CurrentTop +=25
			SetVariable setvarTimeCapSize,win=MainViewPanel, pos={CurrentLeft,CurrentTop},size={85,16},value=TimeCap_Size, title="Size", proc=SetTimeCapFizeProc, disable=1

			CurrentTop +=25
			PopupMenu popupTimeCapPo,win=MainViewPanel, pos={CurrentLeft,CurrentTop},size={91,20},title="Position"
			PopupMenu popupTimeCapPo,win=MainViewPanel,  mode=TimeCap_Pos,value= #"\"LT;LB;RT;RB\"",proc=PopTimeCapPositionProc, disable=1

			NVAR ScaleFlag
			NVAR ScaleBar_Unit
			NVAR ScaleBar_Length
			NVAR ScaleBar_Thickness
			NVAR ScaleBar_LPosi
			NVAR ScaleBar_TPosi

			//NVAR ScaleBar_Color


			NVAR  ScaleCap_Font
			NVAR ScaleCap_LPosi
			NVAR ScaleCap_TPosi



			//ScaleFlag=0

			CurrentTop =20
			CurrentLeft =550
			GroupBox groupScaleBar,win=MainViewPanel, pos={CurrentLeft,CurrentTop},size={155,295},title="Scale", fstyle=1, disable=1

			CurrentTop +=20
			CurrentLeft +=15
			CheckBox CheckScaleCaption, win=MainViewPanel, pos={CurrentLeft,CurrentTop}, title="Add", variable=ScaleFlag , proc=CheckAddScale, disable=1

			CurrentTop +=25
			PopupMenu popupScaleBarUnit, win=MainViewPanel, pos={CurrentLeft,CurrentTop},size={71,20},title="Unit", disable=1
			PopupMenu popupScaleBarUnit,win=MainViewPanel,  mode=ScaleBar_Unit,value= #"\"nm;um\"",proc=PopScaleBarUnitProc, disable=1

			CurrentTop +=25
			SetVariable setvarBarLength, win=MainViewPanel, pos={CurrentLeft,CurrentTop},size={85,24},title="Size", value=ScaleBar_Length, format="%.1f%", proc=SetScaleProc, disable=1
			SetVariable setvarBarLength, limits={1,100,1}

			CurrentTop +=25
			SetVariable setvarBarThick, win=MainViewPanel, pos={CurrentLeft,CurrentTop},size={90,24},title="Thickness", value=ScaleBar_Thickness, format="%d", proc=SetScaleProc, disable=1
			SetVariable setvarBarThick, win=MainViewPanel, limits={1,10,1}

			CurrentTop +=25
			SetVariable setvarBarLPosi, win=MainViewPanel, pos={CurrentLeft,CurrentTop}, size={90,24},title="Left", value=ScaleBar_LPosi, format="%d%", proc=SetScaleProc, disable=1
			SetVariable setvarBarLPosi, win=MainViewPanel, limits={1,100,1}

			CurrentTop +=25
			SetVariable setvarBarTPosi,win=MainViewPanel,  pos={CurrentLeft,CurrentTop},size={90,24},title="Top", value=ScaleBar_TPosi, format="%d%", proc=SetScaleProc, disable=1
			SetVariable setvarBarTPosi, win=MainViewPanel, limits={1,100,1}

			CurrentTop +=25
			SetVariable setvarBarFont, win=MainViewPanel, pos={CurrentLeft,CurrentTop},size={90,24},title="Font Size", value=ScaleCap_Font, format="%d", proc=SetScaleProc, disable=1
			SetVariable setvarBarFont, win=MainViewPanel, limits={1,100,1}

			CurrentTop +=25
			SetVariable setvarCaptionLPosi, win=MainViewPanel, pos={CurrentLeft,CurrentTop},size={120,24},title="Caption Left", value=ScaleCap_LPosi, format="%.1f%", proc=SetScaleProc, disable=1
			SetVariable setvarCaptionLPosi, win=MainViewPanel, limits={-10,50,1}

			CurrentTop +=25
			SetVariable setvarCaptionTPosi, win=MainViewPanel, pos={CurrentLeft,CurrentTop},size={120,24},title="Caption Top", value=ScaleCap_TPosi, format="%.1f%", proc=SetScaleProc, disable=1
			SetVariable setvarCaptionTPosi, win=MainViewPanel, limits={0,100,1}

			////////////

			NVAR FileNameFlag
			NVAR FileNameCap_Size
			NVAR FileNameCap_LPosi
			NVAR FileNameCap_TPosi
			SVAR FileNameCap



			CurrentTop =20
			CurrentLeft =700
			GroupBox groupFileNameCap, win=MainViewPanel, pos={CurrentLeft,CurrentTop},size={170,295},title="File Name", fstyle=1, disable=1

			CurrentTop +=20
			CurrentLeft +=15
			CheckBox CheckFileNameCaption, win=MainViewPanel, pos={CurrentLeft,CurrentTop}, title="Add", variable=FileNameFlag , proc=CheckAddFileName, disable=1


			CurrentTop +=25
			SetVariable setvarFileNamCap, win=MainViewPanel, pos={CurrentLeft,CurrentTop},size={150,24},title=" ",fsize=10,  value=FileNameCap,  proc=SetFileNameProc, disable=1

			CurrentTop +=25
			SetVariable setvarFileNameFont, win=MainViewPanel, pos={CurrentLeft,CurrentTop},size={90,24},title="Font Size", value=FileNameCap_Size, format="%d", proc=SetFileNameProc, disable=1
			SetVariable setvarFileNameFont, win=MainViewPanel, limits={1,100,1}

			CurrentTop +=25
			SetVariable setvarFileNameLPosi, win=MainViewPanel, pos={CurrentLeft,CurrentTop},size={130,24},title="Caption Left", value=FileNameCap_LPosi, format="%.1f%", proc=SetFileNameProc, disable=1
			SetVariable setvarFileNameLPosi, win=MainViewPanel, limits={-10,50,1}

			CurrentTop +=25
			SetVariable setvarFileNameTPosi, win=MainViewPanel, pos={CurrentLeft,CurrentTop},size={130,24},title="Caption Top", value=FileNameCap_TPosi, format="%.1f%", proc=SetFileNameProc, disable=1
			SetVariable setvarFileNameTPosi, win=MainViewPanel, limits={0,100,1}


			//	CurrentTop +=25
			//	PopupMenu popupTimeCapColor, win=MainViewPanel, pos={CurrentLeft,CurrentTop},size={77,20},title="Color"
			//	PopupMenu popupTimeCapColor, win=MainViewPanel, mode=TimeCap_Color,value= #"\"White;Black;Red;Blue\"",proc=PopTimeCapColorProc

			//	CurrentTop +=25
			//	PopupMenu popupTimeCapStyle, win=MainViewPanel, pos={CurrentLeft,CurrentTop},size={77,20},title="Style"
			//	PopupMenu popupTimeCapStyle, win=MainViewPanel, mode=TimeCap_Style,value= #"\"Normal;Bold;Italic;Italic Bold;UnderLine\"",proc=PopTimeCapStyleProc




			CurrentTop =20
			CurrentLeft =873
			GroupBox groupTimeFontCap, win=MainViewPanel, pos={CurrentLeft,CurrentTop},size={145,295},title="Font", fstyle=1, disable=1

			CurrentTop +=20
			CurrentLeft +=15
			PopupMenu popupTimeCapFont, win=MainViewPanel, pos={CurrentLeft,CurrentTop},size={73,20},title="Font"
			PopupMenu popupTimeCapFont,win=MainViewPanel, mode=TimeCap_Font,value= #"\"Arial;Times\"",proc=PopTimeCapFontProc, disable=1

			CurrentTop +=25
			PopupMenu popupTimeCapColor, win=MainViewPanel, pos={CurrentLeft,CurrentTop},size={77,20},title="Color"
			PopupMenu popupTimeCapColor, win=MainViewPanel, mode=TimeCap_Color,value= #"\"White;Black;Red;Green;Blue\"",proc=PopTimeCapColorProc, disable=1

			CurrentTop +=25
			PopupMenu popupTimeCapStyle, win=MainViewPanel, pos={CurrentLeft,CurrentTop},size={77,20},title="Style"
			PopupMenu popupTimeCapStyle, win=MainViewPanel, mode=TimeCap_Style,value= #"\"Normal;Bold;Italic;Italic Bold;UnderLine\"",proc=PopTimeCapStyleProc, disable=1




			/////////////////////////////////


		endif

	Endif //mode==0



	DoWIndow Image1ch

	if(V_Flag==0)

		TabMode=0

		return 0

	endif

	if(mode==1) //TabControl�ŕύX�����ꍇ 0: View 1: Save

		if(TabMode==0)


			ControlInfo/W=MainViewPanel ShowXPixel

			if(v_disable==0)

				TabMode=0
				return 0


			endif

		else
			ControlInfo/W=MainViewPanel SaveBMP

			if(v_disable==0)

				TabMode=1
				return 0


			endif


		endif

		DoWindow Image1ch

		if(v_flag==0)
			TabMode=0
			return 0
		endif

		//MoveWindow/W=MainViewPanel MainViewPanelParams[0], MainViewPanelParams[1], MainViewPanelParams[0]+(MainViewPanelParams[2]-MainViewPanelParams[0])/2.4, MainViewPanelParams[3]

		if(TabMode==1)
			MoveWindow/W=MainViewPanel 10, 400, 700, 600

			MoveWindow/W=MainViewPanel 10, 400, 700, 600
		endif
		//	MoveWindow/W=MainViewPanel 10,10,220,200

		SVAR ViewPanelCtrlList
		ViewPanelCtrlList = ControlNameList("MainViewPanel")

		ViewPanelCtrlList=RemoveFromList("AnalyzeTab", ViewPanelCtrlList)

		variable CtrlNum

		//print ViewPanelCtrlList

		CtrlNum=ItemsInList(ViewPanelCtrlList)

		string CtrlName
		variable i
		for(i=0; i<CtrlNum; i+=1)

			CtrlName=StringFromList(i, ViewPanelCtrlList)

			ControlInfo/W=MainViewPanel $CtrlName

			switch(v_flag)

				case 1:

					Button $CtrlName, win=MainViewPanel, disable = !v_disable


					break

				case 2:

					CheckBox $CtrlName, win=MainViewPanel, disable=!v_disable


					break

				case 3:

					PopupMenu $CtrlName, win=MainViewPanel, disable=!v_disable

					break

				case 4:

					ValDisplay $CtrlName, win=MainViewPanel, disable=!v_disable

					break

				case 5:

					SetVariable $CtrlName, win=MainViewPanel, disable=!v_disable

					break

				case 7:

					Slider $CtrlName, win=MainViewPanel, disable=!v_disable

					break



				case 9:

					GroupBox $CtrlName, win=MainViewPanel, disable=!v_disable

					break

				case 10:

					TitleBox $CtrlName, win=MainViewPanel, disable=!v_disable

					break

				case 11:

					ListBox $CtrlName, win=MainViewPanel, disable=!v_disable

					break


			Endswitch

		endfor

		if(TabMode==0)

		if(Show2chFlag==1)
			CheckBox SwapChCheck,win=MainViewPanel,  disable=0
		else
			CheckBox SwapChCheck,win=MainViewPanel, disable=1
		endif

		if(ScaleMode==0)
		PopupMenu popupRangeMode,win=MainViewPanel, disable=2
		else
		PopupMenu popupRangeMode,win=MainViewPanel, disable=0
		endif

		NVAR SaveModeFlag
		if(SaveModeFlag==1)
		SetVariable SetStartIndex,win=MainViewPanel,disable=1
		SetVariable SetEndIndex,win=MainViewPanel,disable=1
		endif

		elseif(TabMode==1)

		CheckBox SwapChCheck,win=MainViewPanel,  disable=1

		PopupMenu popupRangeMode,win=MainViewPanel, disable=1

		endif

		if(TabMode==1)
			NoteBook MainViewPanel#CommentNote visible=0

			SetVariable setvarLevel,win=MainViewPanel,disable = 1
			SetVariable setvarNum,win=MainViewPanel,disable = 1

			DrawAction/W=MainViewPanel delete
			DoWIndow Image1ch
			if(v_flag==1)
				DoWindow/K Image1ch
				ShowImage(1)
			endif

			NVAR MovieSize
			DoAutoSizeImageFalcon(MovieSize,1)

			NVAR TimeFlag

			if(TimeFlag==1)

				AddTimeCapFirst()

			endif

			NVAR ScaleFlag

			if(ScaleFlag==1 )

				AddScaleCapFirst()

			endif

			NVAR FileNameFlag


			SVAR FileName
			SVAR FileNameCap
			//	strlen(FileName)

			FileNameCap=FileNameOnly(FileName)

			if(FileNameFlag==1 )

				AddFileNameCapFirst()

			endif

			NVAR Check3DSave
			if(Check3DSave==1)

				Check3DSaveProc("",1)// : CheckBoxControl

			endif



		else
			NoteBook MainViewPanel#CommentNote visible=1


			SetVariable setvarLevel,win=MainViewPanel,disable = !CrossFilterFlag
			SetVariable setvarNum,win=MainViewPanel,disable = !CrossFilterFlag

			NVAR SliderSetFlag
			if(SliderSetFlag !=0)
				NVAR RangeLeft,  RangeTop, RangeWidth, RangeHeight

				SetDrawLayer/W=MainViewPanel/K USerFront
				SetDrawENv/W=MainViewPanel linebgc=(65535, 0, 0 ), fillfgc=(65535, 0, 0 ), fillpat=4, linebgc=(65535, 0, 0 ), linefgc=(65535, 0, 0 )

				if(SliderSetFlag ==1)
					DrawRect/W=MainViewPanel  RangeLeft,  RangeTop,  RangeLeft+1,RangeHeight
				elseif(SliderSetFlag ==2)
					DrawRect/W=MainViewPanel RangeLeft,  RangeTop,  RangeWidth,RangeHeight
				endif

			endif

			DoWIndow Image1ch
			if(v_flag==1)
				DoWindow/K Image1ch
				ShowImage(1)
			endif

		endif

		NVAR RecordedIndex
		RecordedIndex=imageIndex






	Endif

	SetDataFolder SavedDataFolder


End


Function MakeInitialFolderPanel() : Panel

      DoWindow InitialFolderPanel
      if(v_flag==1)

        return 0

      endif


	NewPanel/K=1 as "Set Initial Folder"
	DoWindow/C/T InitialFolderPanel, "Set Initial Folder"			//name and title the panel
	SetWindow InitialFolderPanel, hook=KillInitialFolderPanel

	Wave InitialFolderP=root:InitialFolderP
	MoveWindow/W= InitialFolderPanel InitialFolderP[0], InitialFolderP[1], InitialFolderP[2], InitialFolderP[3]


	//	PauseUpdate; Silent 1		// building window...
	//	NewPanel /W=(516,97,886,172)
	//ShowTools/A
	SetDrawLayer UserBack

	SVAR InitialFolder=root:ViewVariables:InitialFolder
	SetVariable SetVArInitialFolder,win=InitialFolderPanel, pos={26,26},size={327,16},title="Initial Folder: "
	SetVariable SetVArInitialFolder,win=InitialFolderPanel, limits={-inf, inf,0}, value=root:ViewVariables:InitialFolder

	Button ButtonInitialFolder, pos={50,70},size={85,40},title="Select Folder", proc=ButtonSelectInitFolderProc


End

Function MakeMovieFolderPanel() : Panel

      DoWindow MovieFolderPanel
      if(v_flag==1)

        return 0

      endif

	NewPanel/K=1 as "Set Movie Folder"
	DoWindow/C/T MovieFolderPanel, "Set Movie Folder"			//name and title the panel

	Wave MovieFolderP=root:MovieFolderP
	MoveWindow/W= MovieFolderPanel MovieFolderP[0], MovieFolderP[1], MovieFolderP[2], MovieFolderP[3]


	//	PauseUpdate; Silent 1		// building window...
	//	NewPanel /W=(516,97,886,172)
	//ShowTools/A
	SetDrawLayer UserBack

	SVAR MovieFolder=root:ViewVariables:MovieFolder
	SetVariable SetVArMovieFolder,win=MovieFolderPanel, pos={26,26},size={327,16},title="Movie Folder: "
	SetVariable SetVArMovieFolder,win=MovieFolderPanel, limits={-inf, inf,0}, value=root:ViewVariables:MovieFolder

	Button ButtonMovieFolderr,win=MovieFolderPanel,  pos={50,70},size={85,40},title="Select Folder", proc=ButtonSelectMovieFolderProc


End

Function MakePICFolderPanel() : Panel

	DoWIndow PICFolderPanel

	if(v_flag==1)

		return 0

	endif

	NewPanel/K=1 as "Set PIC Folder"
	DoWindow/C/T PICFolderPanel, "Set PIC Folder"			//name and title the panel

	Wave MovieFolderP=root:MovieFolderP
	MoveWindow/W= PICFolderPanel MovieFolderP[0], MovieFolderP[1], MovieFolderP[2], MovieFolderP[3]


	//	PauseUpdate; Silent 1		// building window...
	//	NewPanel /W=(516,97,886,172)
	//ShowTools/A
	SetDrawLayer UserBack

	SVAR PICFolder=root:ViewVariables:PICFolder
	SetVariable SetVArPICFolder,win=PICFolderPanel, pos={26,26},size={327,16},title="PIC Folder: "
	SetVariable SetVArPICFolder,win=PICFolderPanel, limits={-inf, inf,0}, value=root:ViewVariables:PICFolder

	Button ButtonPICFolder,win=PICFolderPanel, pos={50,70},size={85,40},title="Select Folder", proc=ButtonSelectPICFolderProc


End

Function ButtonSelectInitFolderProc(ctrlName) : ButtonControl
	String ctrlName

	variable refnum

	string SavedDataFolder = GetDataFolder(1)


	SetDataFolder root:ViewVariables

	SVAR InitialFolder=root:ViewVariables:InitialFolder

	NewPath/M="Which Folder to Browse?"/O/Q InitialFolderPath		//the user sets the fold

	if(V_flag!=0)

		return  0
	endif

	PathInfo InitialFolderPath

	InitialFolder=S_Path

	KillPath  InitialFolderPath


	SetDataFolder SavedDataFolder
End


Function ButtonSelectMovieFolderProc(ctrlName) : ButtonControl
	String ctrlName

	variable refnum

	string SavedDataFolder = GetDataFolder(1)


	SetDataFolder root:ViewVariables

	SVAR MovieFolder=root:ViewVariables:MovieFolder

	NewPath/M="Which Folder to Browse?"/O/Q MoviePath		//the user sets the fold

	if(V_flag!=0)

		return  0
	endif

	PathInfo MoviePath

	MovieFolder=S_Path

	SetDataFolder SavedDataFolder
End

Function ButtonSelectPICFolderProc(ctrlName) : ButtonControl
	String ctrlName

	variable refnum

	string SavedDataFolder = GetDataFolder(1)


	SetDataFolder root:ViewVariables

	SVAR PICFolder=root:ViewVariables:PICFolder

	NewPath/M="Which Folder to Browse?"/O/Q PICPath		//the user sets the fold

	PathInfo PICPath

	PICFolder=S_Path

	SetDataFolder SavedDataFolder
End

Function ButtonSetImageProc(B_Struct)
	STRUCT WMButtonAction &B_Struct


	string SavedDataFolder = GetDataFolder(1)

	if(DataFolderExists("root:ViewVariables"))
		SetDataFolder  root:ViewVariables
	endif


	NVAR FrameNum
	NVAR SliderPos1
	NVAR SliderPos2
	NVAR SliderSetFlag

	NVAR FirstFrame
	NVAR LastFrame
	NVAR RangeLeft, RangeTop, RangeWidth, RangeHeight

	variable SliderPos,   Width, Top,Left, Height

	//NVAR  Width
	//NVAR Top
	//NVAR Left
	//NVAR  Height

	//NVAR
	GetMouse/W=MainViewPanel

	if(v_flag == 2)

		PopupContextualMenu  "Reset"


		strswitch(S_selection)

			case "Reset":
				SliderSetFlag=0
				SetDrawLayer/W=MainViewPanel/K USerFront

				FirstFrame=0
				LastFrame=FrameNum-1
				// do something because "yes" was chosen
				break;

		endswitch

   elseif(v_flag == 1)

		ControlInfo/W=MainViewPanel ImageSlider

		SliderPos=V_value
		Left=V_Left+3
		Width=V_Width-10//+left-17
		Height=V_height
		Top=V_Top


		if(SliderSetFlag==0)

			//SliderPos1=Left+SliderPos*Width/FrameNum+8
			SliderPos1=Round(Left+SliderPos*Width/(FrameNum-1))


			SetDrawLayer/W=MainViewPanel/K USerFront

			SetDrawENv/W=MainViewPanel linebgc=(65535, 0, 0 ), fillfgc=(65535, 0, 0 ), fillpat=4, linebgc=(65535, 0, 0 ), linefgc=(65535, 0, 0 )
			DrawRect/W=MainViewPanel  SliderPos1, top+6,  SliderPos1+1,top+Height


			SliderSetFlag=1

			FirstFrame=V_value

		elseif(SliderSetFlag==1)

			//SliderPos2=Left+SliderPos*Width/FrameNum+8
			SliderPos2=Round(Left+SliderPos*Width/(FrameNum-1))

			SliderSetFlag=2


			SetDrawLayer/W=MainViewPanel/K USerFront

			SetDrawENv/W=MainViewPanel linebgc=(65535, 0, 0 ), fillfgc=(65535, 0, 0 ), fillpat=4, linebgc=(65535, 0, 0 ), linefgc=(65535, 0, 0 )
			DrawRect/W=MainViewPanel  SliderPos1, top+6,  SliderPos2,top+Height

			LastFrame=V_value


		elseif(SliderSetFlag==2)

			variable SliderPos3=Round(Left+SliderPos*Width/(FrameNum-1))

			if(SliderPos3<=SliderPos1 || (SliderPos3>SliderPos1 && SliderPos3<(SliderPos1+SliderPos2)/2))
				SliderPos1=SliderPos3

				FirstFrame=V_value
			else
				SliderPos2=SliderPos3

				LastFrame=V_value
			endif


			SetDrawLayer/W=MainViewPanel/K USerFront

			SetDrawENv/W=MainViewPanel linebgc=(65535, 0, 0 ), fillfgc=(65535, 0, 0 ), fillpat=4, linebgc=(65535, 0, 0 ), linefgc=(65535, 0, 0 )
			DrawRect/W=MainViewPanel  SliderPos1, top+6,  SliderPos2,top+Height



		endif

		if(FirstFrame>LastFrame)
			variable FirstTemp, LAstTemp

			FirstTemp=LastFrame
			LastTemp=FirstFrame

			FirstFrame=FirstTemp
			LastFrame=LastTemp

		endif

		RangeLeft=SliderPos1
		RangeTop=top+6
		RangeWidth=SliderPos2
		RangeHeight=top+Height

	Endif


	SetDataFolder SavedDataFolder

End

Function ButtonSelectFolder(ctrlName) : ButtonControl
	String ctrlName

	variable refnum

	string SavedDataFolder = GetDataFolder(1)

	if(DataFolderExists("root:ViewVariables")!=1)

		DoWindow/K/Z MainViewPanel

		MAkeViewPanel(0)

	endif



	SetDataFolder root:ViewVariables

	DoWindow Image1ch

	if(V_Flag==1)
		DoWindow/k Image1ch
	endif

	DoWindow Image2ch
	if(V_Flag==1)
		DoWindow/k Image2ch
	endif

	NVAR CheckSubFolder

	if(CheckSubFolder==1)
		OpenSubFolder()
		return 0

	endif


	String ImageFileList
	NVAR FileNum=root:ViewVariables:FileNum
	NVAR  DataVer=root:ViewVariables:DataVer //0; Old, 1:New

	SVAR InitialFolder=root:ViewVariables:InitialFolder

	NVAR FileOpenCheck=root:ViewVariables:FileOpenCheck

	if(FileOpenCheck==0)
		NewPath/O/Q/Z  ViewPath, InitialFolder

	endif

	PathInfo/S ViewPath

	NewPath/M="Which Folder to Browse?"/O/Q ViewPath		//the user sets the fold

	if(V_Flag !=0)
		return 0

	endif

	SVAR ImageFilePath
	PathInfo ViewPath
	ImageFilePath=S_Path

	//if (V_flag)
	//	return 1
	//endif
	DataVer=0
	ImageFileList= IndexedFile(ViewPath,-1,".daf")
	strswitch(ImageFileList)
		case "":
			DataVer=1
			break
	endswitch
	if(DataVer==0)
		DoAlert 1, "�f�[�^���Â����܂�"

		ValDisplay ShowIndex, disable=1
		ValDisplay ShowTotalNum, disable=1
		ControlInfo ImageSlider
		if(V_Flag !=0)

			Slider ImageSlider,  win=MainViewPanel, disable=1
		endif

	endif

	if(DataVer==1)

		//ValDisplay ShowIndex, disable=0
		ValDisplay ShowTotalNum, disable=0
		ControlInfo ImageSlider
		if(V_Flag !=0)

			Slider ImageSlider,  win=MainViewPanel, disable=0
		endif


		ImageFileList = IndexedFile(ViewPath,-1,".asd")
	endif

	strswitch(ImageFileList)	// string switch
		case "":		// execute if case matches expression

			ControlInfo /W=MainViewPanel ImageSlider
			//if(V_Flag !=0)
			//	KillCOntrol/W=MainViewPanel ImageSlider
			//endif
			return 0
			break
	endswitch

	FileNum=ItemsInList(ImageFileList, ";")
	variable i,k=0, CheckResult
	string checkstring
	if(DataVer==0)
		for (i=0; i<FileNum; i+=1)
			//	Check=0
			checkstring=StringFromList(k, ImageFileList)
			CheckResult=strsearch(checkstring,"2ch", 0)

			if(CheckResult != -1)

				ImageFileList=RemoveListItem(k,  ImageFileList,";")
				//	Check=1

			endif
			if(CheckResult== -1)
				k +=1
			endif
			//	if(Check==1)
			//		break
			//	endif

		Endfor
	endif

	FileNum=ItemsInList(ImageFileList, ";")
	Make/O/N=(FileNum) ImageListBuddy
	Make/T/O/T/N=(FileNum) ImageList
	Make/T/O/T/N=(FileNum) FolderList
	//SVAR ImageList=root:ViewVariables:ImageList


	for(i=0;i<FileNum; i+=1)

		ImageList[i]=StringFromList(i, ImageFileList)
		ImageListBuddy[i]=0
		FolderList[i]=ImageFilePath
		//ImageList=AddListItem(FileName+"_1","", ";",i)


	Endfor

	ListBox ImageList,font="Arial",win=MainViewPanel, fsize=6,frame=2,mode=4,selWave=root:ViewVariables:ImageListBuddy
	ListBox ImageList,listWave=root:ViewVariables:ImageList, proc=ImageDisplayListFuncAction


	SVAR TextDisplayStringPath=root:ViewVariables:TextDisplayStringPath

	Make/T/O textOutputWave
	Wave/T  textOutputWave=root:ViewVariables:textOutputWave

	textDisplayStringPath = WordWrapControlText(ImageFilePath, textOutputWave, "MainViewPanel", "ShowDataFolder", "groupDataFolder", firstLineNum = 0)


	NVAR OldImageFileIndex

	OldImageFileIndex=-1

	FileOpenCheck+=1

	SetDataFolder SavedDataFolder
End

Function OpenSubFolder()

	string SavedDataFolder = GetDataFolder(1)

	String ImageFileList
	NVAR FileNum=root:ViewVariables:FileNum
	NVAR  DataVer=root:ViewVariables:DataVer //0; Old, 1:New

	SVAR InitialFolder=root:ViewVariables:InitialFolder

	NVAR FileOpenCheck=root:ViewVariables:FileOpenCheck

	if(FileOpenCheck==0)
		NewPath/O/Q/Z  ViewPath, InitialFolder
		PathInfo/S ViewPath
	else
		PathInfo/S ParentFolderForSub //ImageFilePath
	endif

	NewPath/M="Which Folder to Browse?"/O/Q ViewPath		//the user sets the fold

	if(V_Flag !=0)
		return 0

	endif



	SVAR ImageFilePath
	PathInfo ViewPath
	ImageFilePath=S_Path

	NewPath/O/Q ParentFolderForSub,  ImageFilePath

	ImageFileList = IndexedFile(ViewPath,-1,".asd")

	FileNum=ItemsInList(ImageFileList, ";")


	String SubFolder_All
	SubFolder_All=IndexedDir("ViewPath", -1, 0)

	variable FolderNum
	FolderNum=ItemsInList(SubFolder_All, ";")


	variable folder
	String CheckFolder


	for(folder=0; folder<FolderNum; folder+=1)

		CheckFolder=IndexedDir("ViewPath", folder, 0)
		PathInfo ViewPath
		ImageFilePath=S_Path

		ImageFilePath +=CheckFolder
		ImageFilePath +=":"

		NewPath/O/Q CheckFolderPath,  ImageFilePath
		ImageFileList = IndexedFile(CheckFolderPath,-1,".asd")

		FileNum +=ItemsInList(ImageFileList, ";")

	endfor

	Make/O/N=(FileNum) ImageListBuddy
	Make/T/O/T/N=(FileNum) ImageList
	Make/T/O/T/N=(FileNum) FolderList

	ImageFileList = IndexedFile(ViewPath,-1,".asd")

	FileNum=ItemsInList(ImageFileList, ";")



	PathInfo ViewPath
	ImageFilePath=S_Path



	variable FileCount
	variable i
	FileCount=0

	for(i=0;i<FileNum; i+=1)

		ImageList[FileCount]=StringFromList(i, ImageFileList)
		ImageListBuddy[FileCount]=0
		FolderList[FileCount]=ImageFilePath

		FileCount+=1
		//ImageList=AddListItem(FileName+"_1","", ";",i)
	Endfor

	for(folder=0; folder<FolderNum; folder+=1)

		CheckFolder=IndexedDir("ViewPath", folder, 0)
		PathInfo ViewPath
		ImageFilePath=S_Path

		ImageFilePath +=CheckFolder
		ImageFilePath +=":"

		NewPath/O/Q CheckFolderPath,  ImageFilePath
		ImageFileList = IndexedFile(CheckFolderPath,-1,".asd")
		FileNum=ItemsInList(ImageFileList, ";")
		for(i=0;i<FileNum; i+=1)

			ImageList[FileCount]=StringFromList(i, ImageFileList)
			ImageListBuddy[FileCount]=0
			FolderList[FileCount]=ImageFilePath
			FileCount+=1
		Endfor

	endfor

	FileNum=Dimsize(ImageList,0)

	if(FileCount<=0)

		DoAlert 1, "No asd Data"

		return 0

	endif
	//ValDisplay ShowIndex, disable=0
	ValDisplay ShowTotalNum, disable=0
	ControlInfo ImageSlider
	if(V_Flag !=0)

		Slider ImageSlider,  win=MainViewPanel, disable=0
	endif


	ImageFileList = IndexedFile(ViewPath,-1,".asd")

	ListBox ImageList,font="Arial",fsize=6,frame=2,mode=4,selWave=root:ViewVariables:ImageListBuddy

	ListBox ImageList,listWave=root:ViewVariables:ImageList, proc=ImageDisplayListFuncAction

	SVAR TextDisplayStringPath=root:ViewVariables:TextDisplayStringPath

	Make/T/O textOutputWave
	Wave/T  textOutputWave=root:ViewVariables:textOutputWave
	string ImagePath
	ImagePath=FolderList[0]

	textDisplayStringPath = WordWrapControlText(ImagePath, textOutputWave, "MainViewPanel", "ShowDataFolder", "groupDataFolder", firstLineNum = 0)



	NVAR OldImageFileIndex

	OldImageFileIndex=-1

	FileOpenCheck+=1


	KillPath/Z CheckFolderPath

	SetDataFolder SavedDataFolder

end


Function OpenSubFolderAfterEdit()

	string SavedDataFolder = GetDataFolder(1)

	String ImageFileList
	NVAR FileNum=root:ViewVariables:FileNum
	NVAR  DataVer=root:ViewVariables:DataVer //0; Old, 1:New

	//SVAR InitialFolder=root:ViewVariables:InitialFolder

	SVAR ImageFilePath
	//PathInfo ViewPath
	//ImageFilePath=S_Path

	PathInfo ParentFolderForSub
	ImageFilePath=S_Path

	NewPath/O/Q ViewPath,  ImageFilePath

	ImageFileList = IndexedFile(ViewPath,-1,".asd")

	FileNum=ItemsInList(ImageFileList, ";")


	String SubFolder_All
	SubFolder_All=IndexedDir("ViewPath", -1, 0)

	variable FolderNum
	FolderNum=ItemsInList(SubFolder_All, ";")


	variable folder
	String CheckFolder


	for(folder=0; folder<FolderNum; folder+=1)

		CheckFolder=IndexedDir("ViewPath", folder, 0)
		PathInfo ViewPath
		ImageFilePath=S_Path

		ImageFilePath +=CheckFolder
		ImageFilePath +=":"

		NewPath/O/Q CheckFolderPath,  ImageFilePath
		ImageFileList = IndexedFile(CheckFolderPath,-1,".asd")

		FileNum +=ItemsInList(ImageFileList, ";")

	endfor

	Make/O/N=(FileNum) ImageListBuddy
	Make/T/O/T/N=(FileNum) ImageList
	Make/T/O/T/N=(FileNum) FolderList

	ImageFileList = IndexedFile(ViewPath,-1,".asd")

	FileNum=ItemsInList(ImageFileList, ";")



	PathInfo ViewPath
	ImageFilePath=S_Path

	variable FileCount
	variable i
	FileCount=0

	for(i=0;i<FileNum; i+=1)

		ImageList[FileCount]=StringFromList(i, ImageFileList)
		ImageListBuddy[FileCount]=0
		FolderList[FileCount]=ImageFilePath

		FileCount+=1
		//ImageList=AddListItem(FileName+"_1","", ";",i)
	Endfor

	for(folder=0; folder<FolderNum; folder+=1)

		CheckFolder=IndexedDir("ViewPath", folder, 0)
		PathInfo ViewPath
		ImageFilePath=S_Path

		ImageFilePath +=CheckFolder
		ImageFilePath +=":"

		NewPath/O/Q CheckFolderPath,  ImageFilePath
		ImageFileList = IndexedFile(CheckFolderPath,-1,".asd")
		FileNum=ItemsInList(ImageFileList, ";")
		for(i=0;i<FileNum; i+=1)

			ImageList[FileCount]=StringFromList(i, ImageFileList)
			ImageListBuddy[FileCount]=0
			FolderList[FileCount]=ImageFilePath
			FileCount+=1
		Endfor

	endfor

	FileNum=Dimsize(ImageList,0)

	if(FileCount<=0)

		DoAlert 1, "No asd Data"

		return 0

	endif
	//ValDisplay ShowIndex, disable=0
	ValDisplay ShowTotalNum, win=MainViewPanel, disable=0
	ControlInfo ImageSlider
	if(V_Flag !=0)

		Slider ImageSlider,  win=MainViewPanel, disable=0
	endif


	ImageFileList = IndexedFile(ViewPath,-1,".asd")

	ListBox ImageList,win=MainViewPanel, font="Arial",fsize=6,frame=2,mode=4,selWave=root:ViewVariables:ImageListBuddy

	ListBox ImageList,win=MainViewPanel, listWave=root:ViewVariables:ImageList, proc=ImageDisplayListFuncAction

	SVAR TextDisplayStringPath=root:ViewVariables:TextDisplayStringPath

	Make/T/O textOutputWave
	Wave/T  textOutputWave=root:ViewVariables:textOutputWave
	string ImagePath
	ImagePath=FolderList[0]

	textDisplayStringPath = WordWrapControlText(ImagePath, textOutputWave, "MainViewPanel", "ShowDataFolder", "groupDataFolder", firstLineNum = 0)

	ConvertGlobalStringTextEncoding/CONV=4 4,1, textDisplayStringPath

	NVAR OldImageFileIndex

	OldImageFileIndex=-1


	KillPath/Z CheckFolderPath

	SetDataFolder SavedDataFolder

end


Function ButtonAutoView(ctrlName) : ButtonControl
	String ctrlName


	NVAR AutoViewStatus=root:ViewVariables:AutoViewStatus


	NVAR lastRunTicks=root:ViewVariables:lastRunTicks// value of ticks function last time we ran

	lastRunTicks= 0

	AutoViewStatus=1

	Button buttonAutoView,win=MainViewPanel, rename=ButtonAutoViewStop, proc=ButtonAutoViewStopProc,title="*"

	SetBackground AutoView(1)
	CtrlBackground start, period=1



End

Function ButtonAutoViewStopProc(ctrlName) : ButtonControl
	String ctrlName



	NVAR AutoViewStatus=root:ViewVariables:AutoViewStatus



	AutoViewStatus=0

	Button buttonAutoViewStop,win=MainViewPanel, rename=ButtonAutoView, proc=ButtonAutoView,title="�t�t"


End


Function AutoView(mode)

	variable mode

	variable ret

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables

	NVAR  AutoViewStatus

	if( AutoViewStatus== 0 )
		return 1							// not running -- wait for user
	endif

	NVAR lastRunTicks
	NVAR FrameTime

	NVAR ImageIndex=root:ViewVariables:ImageIndex
	NVAR ImageFileIndex=root:ViewVariables:ImageFileIndex
	NVAR FileNum=root:ViewVariables:FileNum
	NVAR FrameNum=root:ViewVariables:FrameNum
	Wave ImageListBuddy=root:ViewVariables:ImageListBuddy
	NVAR DataVer=root:ViewVariables:DataVer
	NVAR DataType2ch=root:ViewVariables:DataType2ch
	NVAR Show2chFlag=root:ViewVariables:Show2chFlag
	NVAR ViewAllFlag=root:ViewVariables:AutoViewAll
	NVAR AutoViewStatus=root:ViewVariables:AutoViewStatus
	NVAR AutoViewSpeed=root:ViewVariables:AutoViewSpeed

	NVAR CheckSwapChFlag=root:ViewVariables:CheckSwapChFlag


	NVAR FrameTime=root:ViewVariables:FrameTime

	Wave ImageListBuddy=root:ViewVariables:ImageListBuddy

	Wave DisplayImage=root:ViewVariables:DisplayImage
	Wave DisplayImage2ch=root:ViewVariables:DisplayImage2ch

	variable TickNum
	TickNum=60*(FrameTime*1e-3)/AutoViewSpeed

	if( (lastRunTicks+TickNum) >= ticks )

		SetDataFolder SavedDataFolder

		return 0							// not time yet, wait
	endif

	if(ViewAllFlag==0)

		ImageIndex +=1

		if(ImageIndex <Framenum)

			ret=tu_DisplayIndexedImage()
			if(ret==1)
				DoAlert 1, "Error: td_DisplayIndexedImage"
				return 0
			endif

			if(CheckSwapChFlag==1)

				Duplicate/O DisplayImage TempSwapImage

				Duplicate/O DisplayImage2ch DisplayImage

				Duplicate/O TempSwapImage DisplayImage2ch

				KIllWaves TempSwapImage

			endif


			if(DataType2ch ==0 || Show2chFlag==0)
				ShowImage( 0)
			endif
			if(DataType2ch !=0 && Show2chFlag==1)
				ShowImage( 0)
				ShowImage2ch( 0)
			endif



		else

			Button buttonAutoViewStop,win=MainViewPanel, rename=ButtonAutoView, proc=ButtonAutoView,title="�t�t"

			SetDataFolder SavedDataFolder

			return 1

		endif

		//DoUpDate

	Endif

	if(ViewAllFlag==1)

		ImageIndex +=1

		if(ImageIndex <Framenum)

			ret=tu_DisplayIndexedImage()
			if(ret==1)
				DoAlert 1, "Error: td_DisplayIndexedImage"
				return 0
			endif

			if(CheckSwapChFlag==1)

				Duplicate/O DisplayImage TempSwapImage

				Duplicate/O DisplayImage2ch DisplayImage

				Duplicate/O TempSwapImage DisplayImage2ch

				KIllWaves TempSwapImage

			endif

			if(DataType2ch ==0 || Show2chFlag==0)
				ShowImage( 0)
			endif
			if(DataType2ch !=0 && Show2chFlag==1)
				ShowImage( 0)
				ShowImage2ch( 0)
			endif

		else

			ImageListBuddy[ImageFileIndex]=0

			ImageFIleIndex+=1

			if(ImageFileIndex<FileNum)

				ImageListBuddy[ImageFileIndex]=1

				ListBox ImageList win=MainViewPanel , Row=ImageFileIndex //,selRow=ImageFileIndex
				DoUpDate

				ImageFileOpen()

				if(DataType2ch ==0 || Show2chFlag==0)
					ShowImage( 0)
				endif
				if(DataType2ch !=0 && Show2chFlag==1)
					ShowImage( 0)
					ShowImage2ch( 0)
				endif

			else
				ImageListBuddy=0
				ImageListBuddy[ImageFileIndex-1]=1

				Button buttonAutoViewStop,win=MainViewPanel, rename=ButtonAutoView, proc=ButtonAutoView,title="�t�t"

				SetDataFolder SavedDataFolder
				return 1



			endif


		endif


	endif


	lastRunTicks= ticks

	SetDataFolder SavedDataFolder

	return 0
End


Function FixScaleViewer(Scale_Mode) : GraphMarquee		//this fixes the scale of the realtime image

	variable Scale_Mode



	NVAR ScaleMode=root:ViewVariables:ScaleMode

	ScaleMode=Scale_Mode

	Wave myColors=root:ViewVariables:myColors
	Wave DisplayImage=root:ViewVariables:DisplayImage

	if(ScaleMode==0)

		WaveStats/Q DisplayImage

		//MaxData=V_max-V_min


		SetScale/I x,V_min,V_max,myColors



	elseif(ScaleMode==1)

		GetAxis/Q Left

		GetAxis/Q Bottom


		GetMarquee/K Left,Bottom					//this gets the marquee coordinates

		variable scale, left, right, top, bottom, xDelta, yDelta

		wave Image = root:ViewVariables:DisplayImage
		xDelta = DimDelta(Image,0)
		yDelta = DimDelta(Image,1)
		left = max(round(V_left/xDelta),0)
		right = max(round(V_right/xDelta),0)
		top = max(round(V_top/yDelta),0)
		bottom = max(round(V_bottom/yDelta),0)


		ImageStats/M=1/G={left,right,bottom,top} Image

		NVAR Max_Scale=root:ViewVariables:Max_Scale
		NVAR Min_Scale=root:ViewVariables:Min_Scale

		Max_Scale=V_max
		Min_Scale=V_min

		SetScale/I x,Min_Scale,Max_Scale,myColors

	Endif

	DoWIndow ColorBarPanel
	if(v_flag==1)
		ModifyImage/W=ColorBarPanel ColorBar, cindex=MyColors
	endif

	//  Wave myColors


end //FixScale

Function ImageDisplayListFuncAction(lba) : ListBoxControl
	STRUCT WMListboxAction &lba

	string SavedDataFolder = GetDataFolder(1)

	if(DataFolderExists( "root:ViewVariables")==0)

	  return 0

	endif

	SetDataFolder root:ViewVariables


	//string  s = KeyboardState("")
	Variable keys = GetKeyState(0)

	Wave ImageListBuddy
	if(WaveExists(ImageListBuddy)==0)

		Make/N=1 ImageListBuddy

	endif


	Wave ImageListBuddy=root:ViewVariables:ImageListBuddy
	NVAR ImageFileIndex=root:ViewVariables:ImageFileIndex
	//ImageListBuddy=0
	//ImageListBuddy[ImageFileIndex]=1

	switch(lba.eventCode )
		case 1: // control being killed

			ListBoxUpdate(lba.eventCode,lba.row, keys)

			break
		case 3: // double click
			ListBoxUpdate(lba.eventCode,lba.row, keys)
			break
		case 4:

			ListBoxUpdate(lba.eventCode,lba.row, keys)
			//ImageFileOpen()

			// cell selection
		case 5: // cell selection plus shift key

			break
		case 6: // begin edit
			break
		case 7: // finish edit
			break
	endswitch

	SetDataFolder SavedDataFolder

	return 0


End

Function KilledListFuncAction(lba) : ListBoxControl
	STRUCT WMListboxAction &lba

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables

	DoWIndow EditPanel

	Wave KilledListBuddy
	Wave/T KilledFolderList

	variable i

	switch( lba.eventCode )
		case 1: // control being killed

			SVAR  textKilledFilaPath

			for(i=0;i<DimSize(KilledListBuddy,0); i+=1)

				if(KilledListBuddy[i]==1)
					textKilledFilaPath =KilledFolderList[i]
				endif

			endfor
			//ListBoxUpdate(lba.eventCode,lba.row, s)

			break
		case 3: // double click
			//ListBoxUpdate(lba.eventCode,lba.row, s)
			break
		case 4:

			//ListBoxUpdate(lba.eventCode,lba.row, s)
			//ImageFileOpen()

			// cell selection
		case 5: // cell selection plus shift key

			break
		case 6: // begin edit
			break
		case 7: // finish edit
			break
	endswitch

	SetDataFolder SavedDataFolder

	return 0


End




Function CheckSaveASDProc(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked


	if(checked==1)
		NVAR SaveAllFlag=root:ViewVariables:SaveAllFlag

		SaveAllFlag=1

	endif

End

Function CheckSaveAllProc(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked

	if(checked==0)
		NVAR SaveACDFlag=root:ViewVariables:SaveACDFlag

		if(SaveACDFlag==1)
			SaveACDFlag=0
		endif

	endif

End


static Function ListBoxUpdate(eventCode,row, keys)
	variable eventCode
	variable row
	variable keys

	variable ret

	string SavedDataFolder = GetDataFolder(1)
	SetDataFolder root:ViewVariables



	NVAR ImageIndex=root:ViewVariables:ImageIndex
	NVAR ImageFileIndex=root:ViewVariables:ImageFileIndex
	NVAR FileNum=root:ViewVariables:FileNum
	NVAR FrameNum=root:ViewVariables:FrameNum
	Wave ImageListBuddy=root:ViewVariables:ImageListBuddy
	NVAR DataVer=root:ViewVariables:DataVer
	NVAR DataType2ch=root:ViewVariables:DataType2ch
	NVAR Show2chFlag=root:ViewVariables:Show2chFlag
	NVAR CheckSwapChFlag=root:ViewVariables:CheckSwapChFlag

	Wave DisplayImage=root:ViewVariables:DisplayImage
	Wave DisplayImage2ch=root:ViewVariables:DisplayImage2ch

	NVAR OldImageFileIndex

	NVAR ContinMode

	NVAR Process=root:ImageProcessVariables:Process
	process=0

	if(eventCode==1 ) //Click

		DoWIndow Image1ch

		if(OldImageFileIndex ==row && V_Flag==1 )
			ret=tu_DisplayIndexedImage()
			if(ret==1)
				DoAlert 1, "Error: td_DisplayIndexedImage"
				return 0
			endif

			if(CheckSwapChFlag==1)

				Duplicate/O DisplayImage TempSwapImage

				Duplicate/O DisplayImage2ch DisplayImage

				Duplicate/O TempSwapImage DisplayImage2ch

				KIllWaves TempSwapImage

			endif

			if(DataType2ch ==0 || Show2chFlag==0)
				ShowImage( 0)
			endif
			if(DataType2ch !=0 && Show2chFlag==1)
				ShowImage(0)
				ShowImage2ch( 0)
			endif



		else
			ImageIndex=0
			ImageFIleIndex=row

			if(ImageFileIndex <0)

				ImageFIleIndex=0

			endif

			if(numpnts(ImageListBuddy)>ImageFileIndex)

				ImageListBuddy[ImageFileIndex]=1

				ImageFileOpen()

			endif
		endif

		OldImageFileIndex=ImageFileIndex


	endif

	if(eventCode==3 ) //double Click

		if(OldImageFileIndex ==row && V_Flag==1 )

			ImageIndex=0
			ret=tu_DisplayIndexedImage()
			if(ret==1)
				DoAlert 1, "Error: td_DisplayIndexedImage"
				return 0
			endif

			if(CheckSwapChFlag==1)

				Duplicate/O DisplayImage TempSwapImage

				Duplicate/O DisplayImage2ch DisplayImage

				Duplicate/O TempSwapImage DisplayImage2ch

				KIllWaves TempSwapImage

			endif

			if(DataType2ch ==0 || Show2chFlag==0)
				ShowImage( 0)
			endif
			if(DataType2ch !=0 && Show2chFlag==1)
				ShowImage(0)
				ShowImage2ch( 0)
			endif



		else
			ImageIndex=0
			ImageFIleIndex=row

			if(numpnts(ImageListBuddy)>ImageFileIndex)

				if(ImageFileIndex <0)
					ImageFileIndex=0
				endif

				ImageListBuddy[ImageFileIndex]=1

				ImageFileOpen()

			Endif
		endif

		OldImageFileIndex=ImageFileIndex


	endif

	if(eventCode==4) //KeyBoard

		if (keys == 2^6) //Decrement of  OffsetX

			ImageIndex -=1

			if(ContinMode==0)

				if(ImageIndex<0)
					ImageIndex=0
				endif

			elseif(ContinMode==1)

				if(ImageIndex<0)

					ImageListBuddy[ImageFileIndex]=0
					ImageFIleIndex-=1

					ListBox ImageList win=MainViewPanel ,selRow=ImageFileIndex
					//	DoUpDate

					if(ImageFileIndex<0)
						ImageFileIndex=0
					Endif
					ImageListBuddy[ImageFileIndex]=1

					ImageFileOpen()

					ImageIndex=FrameNum-1

				endif
			endif

			ret=tu_DisplayIndexedImage()
			if(ret==1)
				DoAlert 1, "Error: td_DisplayIndexedImage"
				return 0
			endif

			if(CheckSwapChFlag==1)

				Duplicate/O DisplayImage TempSwapImage

				Duplicate/O DisplayImage2ch DisplayImage

				Duplicate/O TempSwapImage DisplayImage2ch

				KIllWaves TempSwapImage

			endif

			if(DataType2ch ==0 || Show2chFlag==0)
				ShowImage( 0)
			endif
			if(DataType2ch !=0 && Show2chFlag==1)
				ShowImage( 0)
				ShowImage2ch( 0)
			endif

			DoWIndow WICheckPanel
			if(v_flag==1)

				NVAR WI_CurrentFrame=root:Analysis:ImageTracking:CurrentFrame

				WI_CurrentFrame =ImageIndex

				Wave TrackingImage= root:analysis:ImageTracking:TrackingImage
				Wave DisplayImage=root:ViewVariables:DisplayImage
				NVAR CurrentFrame= root:analysis:ImageTracking:CurrentFrame
				NVAR FirstFrame=root:ViewVariables:FirstFrame

				Slider sliderIndex_WI,win=WICheckPanel, value=CurrentFrame

				Duplicate/O  DisplayImage TrackingImage

				Wave CenterPointX=root:analysis:ImageTracking:CenterPointX
				Wave CenterPointY=root:analysis:ImageTracking:CenterPointY

				Cursor/P/I/A=1/W=WITrackingImagePanel/C=(65535,0,0 ) A , TrackingImage,CenterPointX[CurrentFrame-FirstFrame],CenterPointY[CurrentFrame-FirstFrame]

			endif
			//		DoWIndow WICheckPanel
			//
			//		if(V_flag==1)
			//
			//			SetDataFolder root:analysis:ImageTracking
			//
			//			Wave TrackingImage= root:analysis:ImageTracking:TrackingImage
			//			Wave DisplayImage=root:ViewVariables:DisplayImage
			//
			//			NVAR CurrentFrame= root:analysis:ImageTracking:CurrentFrame
			//			NVAR FirstFrame=root:ViewVariables:FirstFrame
			//
			//
			//			Duplicate/O  DisplayImage TrackingImage
			//
			//			Wave CenterPointX= root:analysis:ImageTracking:CenterPointX
			//			Wave CenterPointY= root:analysis:ImageTracking:CenterPointY
			//
			//			Cursor/P/I/A=1/W=WITrackingImagePanel/C=(65535,0,0 ) A , TrackingImage,CenterPointX[CurrentFrame-FirstFrame],CenterPointY[CurrentFrame-FirstFrame]
			//
			//
			//			SetDataFolder root:ViewVariables
			//
			//
			//		endif

		endif
		if (keys == 2^7)  //Increment of  OffsetX

			ImageIndex +=1

			if(ContinMode==0)

				if(ImageIndex>(FrameNum-1))
					ImageIndex=FrameNum-1
				endif

			elseif(ContinMode==1)


				if(ImageIndex>(FrameNum-1))
					//	ImageIndex=FrameNum-1
					ImageIndex=0

					ImageListBuddy[ImageFileIndex]=0

					ImageFIleIndex+=1
					ListBox ImageList win=MainViewPanel ,selRow=ImageFileIndex
					//DoUpDate

					if(ImageFileIndex>FileNum-1)
						ImageFileIndex=FileNum-1
					Endif
					ImageListBuddy[ImageFileIndex]=1

					ImageFileOpen()

				endif
			endif

			ret=tu_DisplayIndexedImage()
			if(ret==1)
				DoAlert 1, "Error: td_DisplayIndexedImage"
				return 0
			endif

			if(CheckSwapChFlag==1)

				Duplicate/O DisplayImage TempSwapImage

				Duplicate/O DisplayImage2ch DisplayImage

				Duplicate/O TempSwapImage DisplayImage2ch

				KIllWaves TempSwapImage

			endif

			if(DataType2ch ==0 || Show2chFlag==0)
				ShowImage( 0)
			endif
			if(DataType2ch !=0 && Show2chFlag==1)
				ShowImage( 0)
				ShowImage2ch( 0)
			endif

			DoWIndow WICheckPanel
			if(v_flag==1)

				NVAR WI_CurrentFrame=root:Analysis:ImageTracking:CurrentFrame

				WI_CurrentFrame =ImageIndex

				Wave TrackingImage= root:analysis:ImageTracking:TrackingImage
				Wave DisplayImage=root:ViewVariables:DisplayImage
				NVAR CurrentFrame= root:analysis:ImageTracking:CurrentFrame
				NVAR FirstFrame=root:ViewVariables:FirstFrame


				Slider sliderIndex_WI,win=WICheckPanel, value=CurrentFrame

				Duplicate/O  DisplayImage TrackingImage

				Wave CenterPointX=root:analysis:ImageTracking:CenterPointX
				Wave CenterPointY=root:analysis:ImageTracking:CenterPointY

				Cursor/P/I/A=1/W=WITrackingImagePanel/C=(65535,0,0 ) A , TrackingImage,CenterPointX[CurrentFrame-FirstFrame],CenterPointY[CurrentFrame-FirstFrame]

			endif

		endif

		if (keys == 2^8) ////Decrementt of  OffsetY
			ImageListBuddy[ImageFileIndex]=0

			ImageFIleIndex-=1

			if(ImageFileIndex<0)
				ImageFileIndex=0
			Endif
			ImageListBuddy[ImageFileIndex]=1

			ListBox ImageList win=MainViewPanel ,selRow=ImageFileIndex
			//DoUpDate

			ImageFileOpen()

		endif

		if (keys == 2^9) //Increment of  Offsety
			ImageListBuddy[ImageFileIndex]=0

			ImageFIleIndex+=1

			if(ImageFileIndex>FileNum-1)
				ImageFileIndex=FileNum-1
			Endif
			ImageListBuddy[ImageFileIndex]=1

			ListBox ImageList win=MainViewPanel ,selRow=ImageFileIndex
			//DoUpDate

			ImageFileOpen()

		endif

	endif

	SetDataFolder SavedDataFolder

	return 0
End

Function SetSlider()

	NVAR FrameNum=root:ViewVariables:FrameNum
	NVAR ImageIndex=root:ViewVariables:ImageIndex

	ImageIndex=0

	Slider ImageSlider win=MainViewPanel,limits={0,FrameNum-1,1},variable= ImageIndex, proc=IndexSliderProc


End

Function IndexSliderProc(name, value, event)
	String name	// name of this slider control
	Variable value	// value of slider
	Variable event	// bit field: bit 0: value set; 1: mouse down,
	//   2: mouse up, 3: mouse moved
	variable ret

	string SavedDataFolder = GetDataFolder(1)


	SetDataFolder root:ViewVariables


	NVAR ImageIndex=root:ViewVariables:ImageIndex

	ImageIndex=value

	Wave ImageListBuddy=root:ViewVariables:ImageListBuddy
	Wave ImageList=root:ViewVariables:ImageList


	NVAR ImageIndex=root:ViewVariables:ImageIndex
	NVAR ImageFileIndex=root:ViewVariables:ImageFileIndex
	NVAR FileNum=root:ViewVariables:FileNum
	NVAR FrameNum=root:ViewVariables:FrameNum

	NVAR DataVer=root:ViewVariables:DataVer
	NVAR DataType2ch=root:ViewVariables:DataType2ch
	NVAR Show2chFlag=root:ViewVariables:Show2chFlag
	NVAR CheckSwapChFlag=root:ViewVariables:CheckSwapChFlag

	Wave DisplayImage=root:ViewVariables:DisplayImage
	Wave DisplayImage2ch=root:ViewVariables:DisplayImage2ch

	if(WaveExists(ImageList)==0)
		return 0
	endif


	WaveStats/Q ImageListBuddy

	if(V_max==0)
		return 0

	endif

	//print ImageIndex

	ret=tu_DisplayIndexedImage()
	if(ret==1)
		DoAlert 1, "Error: td_DisplayIndexedImage"
		return 0
	endif

	if(CheckSwapChFlag==1)

		Duplicate/O DisplayImage TempSwapImage

		Duplicate/O DisplayImage2ch DisplayImage

		Duplicate/O TempSwapImage DisplayImage2ch

		KIllWaves TempSwapImage

	endif

	NVAR Process=root:ImageProcessVariables:Process
	process=0


	if(DataType2ch ==0 || Show2chFlag==0)
		ShowImage( 0)
	endif
	if(DataType2ch !=0 && Show2chFlag==1)
		ShowImage( 0)
		ShowImage2ch( 0)
	endif


	SetDataFolder SavedDataFolder

	return 0	// other return values reserved
End


Function ShowImage(Process_flag)

	variable  Process_flag

	variable ret

	string SavedDataFolder = GetDataFolder(1)


	SetDataFolder root:ViewVariables



	NVAR Process=root:ImageProcessVariables:Process
	Process=Process_Flag

	variable ScrRes = 72/ScreenResolution		//probably unneeded
	variable Width, Height, Top, ScreenNum

	FVScreenSize(Width,Height, ScreenNum)


	// Duplicate/O  $ImageWaveName,DisplayImage
	//DisplayImage *=1e-9

	Wave DisplayImage
	if(WaveExists(DisplayImage)==0)
		Make/N=(1,1) DisplayImage
	endif

	Wave RowDisplayImage
	if(WaveExists(RowDisplayImage)==0)
		Make/N=(1,1) RowDisplayImage
	endif



	//SetDataFolder root:ImageProcessVariables
	NVAR  CheckRemoveBG1ch=root:ImageProcessVariables:CheckRemoveBG1ch
	NVAR SetRemoveOrder1ch=root:ImageProcessVariables:SetRemoveOrder1ch
	NVAR CheckRemoveLineBG1ch=root:ImageProcessVariables:CheckRemoveLineBG1ch
	NVAR SetRemoveLineOrder1ch=root:ImageProcessVariables:SetRemoveLineOrder1ch
	NVAR CheckAllFilter1ch=root:ImageProcessVariables:CheckAllFilter1ch
	SVar SetFilterType1ch=root:ImageProcessVariables:SetFilterType1ch
	NVAR SetFilterNum1ch=root:ImageProcessVariables:SetFilterNum1ch
	NVAR CheckFFT_Flag=root:ImageProcessVariables:CheckFFT_Flag
	NVAR CheckManualRBG=root:ImageProcessVariables:CheckManualRBG
	NVAR Invert=root:ViewVariables:Invert

	/////2016/9/15
	NVAR CheckOffFlatten1ch=root:ImageProcessVariables:CheckOffFlatten1ch
	NVAR CheckMedianFlatten1ch=root:ImageProcessVariables:CheckMedianFlatten1ch
	NVAR CheckMedianDifFlatten1ch=root:ImageProcessVariables:CheckMedianDifFlatten1ch
	NVAR CheckMeanFlatten1ch=root:ImageProcessVariables:CheckMeanFlatten1ch
	////

	NVAR PopFlattenDirection1ch= root:ImageProcessVariables:PopFlattenDirection1ch



	NVAR XPixel=root:ViewVariables:XPixel
	NVAR YPixel=root:ViewVariables:YPixel
	NVAR OldYPixel
	NVAR SizeChanged=root:ImageProcessVariables:SizeChanged

	NVAR MaxData=root:ViewVariables:MaxData

	NVAR XScanSize=root:ViewVariables:XScanSize
	NVAR YScanSize=root:ViewVariables:YScanSize


	NVAR CrossFilterFlag=root:ViewVariables:CrossFilterFlag
	NVAR CrossFilterLevel=root:ViewVariables:CrossFilterLevel
	NVAR CrossFilterNum=root:ViewVariables:CrossFilterNum

	NVAR CheckRemoveScars1ch= root:ImageProcessVariables:CheckRemoveScars1ch
	NVAR ScarsLength1ch= root:ImageProcessVariables:ScarsLength1ch

	NVAR CheckShowRange=root:ViewVariables:CheckShowRange
	NVAR TabMode=root:ViewVariables:TabMode


	NVAR OldXSize=root:ViewVariables:OldXSize
	NVAR OldYSize=root:ViewVariables:OldYSize

	NVAR  ImageIndex=root:ViewVariables:ImageIndex

	NVAR Show2chFlag=root:ViewVariables:Show2chFlag

	NVAR CheckSwapChFlag=root:ViewVariables:CheckSwapChFlag


	Wave DisplayImage=root:ViewVariables:DisplayImage
	Wave DisplayImage2ch=root:ViewVariables:DisplayImage2ch
	Wave RowDisplayImage=root:ViewVariables:RowDisplayImage



	variable i


	SetScale x, 0, XScanSize*1e-9, "m",DisplayImage
	SetScale y ,0, YScanSize*1e-9,"m", DisplayImage

	if(CrossFilterFlag==0 || Process_flag ==0)
		SetDataFolder  root:ViewVariables
		NVAR ImageIndex
		tu_DisplayIndexedImage()

		if(CheckSwapChFlag==1)

			Duplicate/O DisplayImage TempSwapImage

			Duplicate/O DisplayImage2ch DisplayImage

			Duplicate/O TempSwapImage DisplayImage2ch

			KIllWaves TempSwapImage

		endif

		SetScale x, 0, XScanSize*1e-9, "m",DisplayImage
		SetScale y ,0, YScanSize*1e-9,"m", DisplayImage
		Duplicate/O DisplayImage, RowDisplayImage

		if( Show2chFlag==1)

			ShowImage2ch(0)

		endif

	endif

	if(process_Flag != 0 )

		DisplayImage=RowDisplayImage

	endif

	if(Invert==1)
		DisplayImage *=-1
	endif

	//WaveStats/Q DisplayImage
	//DisplayImage -=v_min




	if(CheckRemoveBG1ch==1)

		Make/O/B/U/N=(Dimsize(DisplayImage,0),Dimsize(DisplayImage,1)) ROImask
		FastOP ROImask=1


		ImageRemoveBackGround/R=ROImask/O/P=(SetRemoveOrder1ch)  DisplayImage

	endif

	if(CheckManualRBG==1)
		NVAR imageindex

		if( DataFOlderExists(" root:ImageProcessVariables:SaveMRBGWave")==0)


			wave MRBGWave=root:ImageProcessVariables:MRBGWave
			DisplayImage +=MRBGWave


		elseif(DataFOlderExists("root:ImageProcessVariables:SaveMRBGWave")==1)


			if(WaveExists($"root:ImageProcessVariables:SaveMRBGWave:MRBGWave_"+num2str(imageindex))==1)

				Wave MRBGWave=$"root:ImageProcessVariables:SaveMRBGWave:MRBGWave_"+num2str(imageindex)

				if(DImsize(DisplayImage,0) != Dimsize(MRBGWave,0) || DImsize(DisplayImage,1) != Dimsize(MRBGWave,1))

					DoAlert 0, "Can't subtract the background"

					CheckManualRBG=0
				else
					DisplayImage +=MRBGWave
				endif

			else

				variable check=0
				for(i=ImageIndex; i>=0; i-=1)

					if(WaveExists($"root:ImageProcessVariables:SaveMRBGWave:MRBGWave_"+num2str(i))==1)

						Wave MRBGWave=$"root:ImageProcessVariables:SaveMRBGWave:MRBGWave_"+num2str(i)

						DisplayImage +=MRBGWave
						break

					endif

				endfor

			endif

		endif

	endif


	if(CheckRemoveLineBG1ch==1 || CheckMedianFlatten1ch==1 || CheckMedianDifFlatten1ch==1 ||  CheckMeanFlatten1ch==1 )

		Duplicate/O DisplayImage FlattenImage

		if(PopFlattenDirection1ch==2)
			ImageRotate /A=(90)/E=(0)/O FlattenImage
		endif


		if(CheckRemoveLineBG1ch==1)



			ret=tu_Flatten(FlattenImage, SetRemoveLineOrder1ch)


		endif

		if(CheckMedianFlatten1ch==1)


			FlattenMedian(FlattenImage)


		elseif(CheckMedianDifFlatten1ch==1)



			FlattenMedianDif(FlattenImage)

		elseif(CheckMeanFlatten1ch==1)

			FlattenMean(FlattenImage)

		endif


		if(PopFlattenDirection1ch==2)
			ImageRotate /A=(-90)/E=(0)/O FlattenImage
		endif


		Duplicate/O FlattenImage DisplayImage

	endif


	if(CheckRemoveScars1ch==1)

		RemoveScars(DisplayImage, ScarsLength1ch)

	endif

	if(CheckAllFilter1ch==1)

		DoFilter(SetFilterType1ch,SetFilterNum1ch, DisplayImage)

	endif

	if(CrossFilterFlag==1)

		ret=tu_CrossFilter(DisplayImage, CrossFilterNum,CrossFilterLevel)


	endif

	if(CheckFFT_Flag==1)
		variable/G OldNumPnts

		NVAR  ImageIndex=root:ViewVariables:ImageIndex

		MakeFFTImage("root:ViewVariables:DisplayImage")
		DoWIndow FFTFilterPanel
		if(V_flag==1)
			MakeROIImage()
		else
			if(numpnts(DisplayImage) !=OldNumPnts || ImageIndex==0)
				MakeROIImage()
			endif

		endif


		DoInvFFT("root:ViewVariables:DisplayImage")

		wave DisplayImage_magShow=root:ViewVariables:FFT_Filter:DisplayImage_magShow
		OldNumPnts=numpnts(DisplayImage_magShow)

	endif




	wave MyColors=root:ViewVariables:myColors

	DoWindow Image1ch
	variable WindowCheck=V_flag

	if(WindowCheck==1)

		RemoveImage/Z/W=Image1ch  //$OldImageWaveName

		SizeChanged=0
		if(YPixel != OldYPixel)


			GetWindow Image1ch, wsize

			MoveWIndow/W=Image1ch V_left,V_top,v_left+height/3,v_top+height/3*YScanSize/XScanSize
			SizeChanged=1

		endif
	endif

	if(WindowCheck==0)
		variable Ratio

		NVAR SaveFlag

		if(CheckShowRange==0 && TabMode==1)

			NewImage/K=2/S=0/F/N=Image1ch DisplayImage

		elseif((CheckShowRange==1 && TabMode==1) || TabMode==0)

			NewImage/K=2/S=2/F/N=Image1ch DisplayImage

		endif



		MoveWIndow/W=Image1ch 10,10,height/3,height/3*YScanSize/XScanSize

		SetWIndow Image1ch, hook=ImageHook


		ModifyImage DisplayImage cindex=myColors

	endif



	NVAR ScaleMode=root:ViewVariables:ScaleMode

	//	//////////////
	DoWindow ContrastAdjustGraph

	if(v_flag==1)

		SVAR ImGrfName= root:ImageProcessVariables:ImageContrast:ImGrfName

		Wave wclu= root:ViewVariables:DisplayImage_CLU

		WaveStats/Q DisplayImage
		Variable nzmin2,nzmax2,dz

		nzmin2= V_min

		nzmax2= V_max

		dz= nzmax2-nzmin2
		DisplayImage= wclu((DisplayImage-nzmin2)/dz)*dz+nzmin2



	endif
	////

	if(ScaleMode==0)

		variable maxVal=WaveMAx(DisplayImage)
		variable miniVal=WaveMin(DisplayImage)

		MaxData=maxVal-MiniVal

		DoWindow Image1ch

		if(V_Flag==1)
			ModifyImage/W=Image1ch DisplayImage, cindex=MyColors
		endif

		SetScale/I x,miniVal,maxVal,myColors

	else

		NVAR Max_Scale=root:ViewVariables:Max_Scale
		NVAR Min_Scale=root:ViewVariables:Min_Scale

		NVAR RangeMode=root:ViewVariables:RangeMode

		DoWIndow WMImageRangeGraph

		if(V_flag==1)
			WMImageRangeDoHist_F("Image1ch")
		endif

		Wave HistWave=root:ViewVariables:DisplayImage_WMUF:hist

		if(RangeMode==0)


			WaveStats/Q DisplayImage


			DisplayImage -=v_min //V_avg

		elseif(RangeMode==1)


			WaveStats/Q DisplayImage


			DisplayImage -=V_max

		elseif(RangeMode==2)


			WaveStats/Q DisplayImage

			DisplayImage -=V_min


		elseif(RangeMode==3)


			variable MaxZ

			WaveStats/Q HistWave
			MaxZ=V_maxRowLoc*DimDelta(HistWave,0)+DimOffset(HistWave,0)

			DisplayImage -=MaxZ

		endif

		WMImageRangeDoHist_F("Image1ch")

		wave hist=root:ViewVariables:DisplayImage_WMUF:hist

		//WMImageRangeAdjustGraph_F(hist)
		NVAR ScaleModeFlag=root:ViewVariables:ScaleModeFlag
		//if(ScaleModeFlag==1)
		WMUpdateImageRangeAdjustGraph_F(hist, DisplayImage, "image1ch",0)
		//endif

		//string s=TraceInfo("WMImageRangeGraph","zminDrag", 0)

		String info = TraceInfo("WMImageRangeGraph" ,"zminDrag", 0)
		String offsetStr = StringByKey("offset(x)", info, "=")

		Variable minOffset=0, maxOffset=0, yOffset=0

		if (strlen(offsetStr) > 0)
			sscanf offsetStr, "{%g,%g}", minOffset, yOffset
		endif

		info = TraceInfo("WMImageRangeGraph" ,"zmaxDrag", 0)
		offsetStr = StringByKey("offset(x)", info, "=")

		if (strlen(offsetStr) > 0)
			sscanf offsetStr, "{%g,%g}", maxOffset, yOffset
		endif


		NVAR nzmax= root:Packages:WMImProcess:ImageRange:zmax
		NVAR nzmin= root:Packages:WMImProcess:ImageRange:zmin

		nzmax=maxoffset
		nzmin=minOffset

		SetScale/I x,nzmin,nzmax,myColors
		//SetScale/I x,nzmin,nzmin+9,myColors


		ModifyImage/W=Image1ch DisplayImage,cindex=myColors
		//ModifyImage/W=Image1ch DisplayImage ctab= {nzmin,nzmax,} //,cindex=myColors
		DoUpDate
	endif



	DoWIndow ColorBarPanel
	if(v_flag==1)

         ShowColorBar()




	endif




	DoWindow ImageLineProfileGraph
	if( V_flag==1)

		SetDataFolder root:LineProfile

		if(OldXSize != XScanSize ||  OldYSize != YScanSize)
			ButtonResetProc("")
		else

			DrawProfile()

		endif

		SetDataFolder root:ViewVariables

	endif

	OldYPixel=YPixel
	OldXSize = XScanSize
	OldYSize = YScanSize


	NVAR TabMode

	if(TabMode==0)

		ListBox  ImageList, activate, win=MainViewPanel

	endif


	//ShowConfChange()

	//NVAR Check_F1

	NVAR imageindex
	NVAR  FirstFrame

	//	if(Check_F1==1)
	//
	//		WaveStats/Q DisplayImage
	//
	//		DisplayImage -=V_Avg
	//
	//		if(imageindex==FirstFrame)
	//
	//
	//			//	AppendImage/W=Image1ch M_ROIMask
	//			//   ModifyImage M_ROIMask,explicit=1,eval={0, -1, 0, 0 },eval={1,0, 0, 255}
	//
	//		endif
	//
	//	endif




	//  WaveStats/Q DisplayImage

	//variable Zheight

	// Zheight=v_max-v_min

	//  Colorscale/C/N=Imagr1ch  trace=DisplayImage, cindex=mycolors axisRange={0, Zheight} heightPCT=50, "Z Scale (nm)"
	//DisplayImage -=V_Avg

	DoWIndow MarkImagePanel

	if(V_flag==1)

		Wave MarkImage=root:Analysis:MoleculeMark:MarkImage

		Duplicate/O DisplayImage MarkImage


		Wave MarkedWave=root:Analysis:MoleculeMark:MArkedWave

		NVAR CurrentNum=root:ViewVariables:CurrentNum

		Cursor/P/I/A=1/W=MarkImagePanel/C=(65535,0,0 ) A , MarkImage, MarkedWave[CurrentNum][0], MarkedWave[CurrentNum][1]


	endif

	DoWIndow ShowTrackedImagePanel

	if(v_flag ==1)


		Wave StackedImage = root:Analysis:MoleculeTracking:StackedImage
		Wave TrackedImage= root:Analysis:MoleculeTracking:TrackedImage
		Wave DiffImage= root:Analysis:MoleculeTracking:DiffImage
		Wave AveImage= root:Analysis:MoleculeTracking:AveImage

//	variable test=DimSize(StackedImage,2)
	     if(DimSize(StackedImage,2)>ImageIndex-FirstFrame)

		TrackedImage[][]=StackedImage[p][q][ImageIndex-FirstFrame]
		DiffImage=TrackedImage-AveImage

		endif

	endif

	DoWIndow ShowShiftImagePanel

	if(v_flag ==1)



		Wave StackedImage = root:Analysis:ImageShift:StackedImage
		Wave ShiftImage=root:Analysis:ImageShift:ShiftImage
		Wave DiffImage=root:Analysis:ImageShift:DiffImage
		Wave AveImage= root:Analysis:ImageShift:AveImage

		  if(DimSize(StackedImage,2)>ImageIndex-FirstFrame)

		  ShiftImage[][]=StackedImage[p][q][ImageIndex-FirstFrame]

		DiffImage=ShiftImage-AveImage

		  endif




	endif

	//ShowMarkonForMovie( ImageIndex)

	//ShowLaser()

	//	DoWIndow DwellImagePanel
	//
	//	if(V_flag==1)
	//
	//		Wave DwellImage=root:Analysis:DwellAnalysis:DwellImage
	//
	//		Duplicate/O DisplayImage DwellImage
	//
	//		//   ShowMark()
	//
	//		//	      CheckDwellPos()
	//
	//	endif
	//
	//	DoWIndow BindingImagePanel
	//
	//	if(V_flag==1)
	//
	//		Wave BindingImage=root:Analysis:BindingAnalysis:BindingImage
	//
	//		Duplicate/O DisplayImage BindingImage
	//
	//		// ShowMarkBinding()
	//
	//		//	      CheckDwellPos()
	//
	//	endif
	//
	//
	//	// ShowMarkV()
	//
	//	DoUpDate


	SetDataFolder SavedDataFolder

End



Function ImageHook(InfoStr)
	String infoStr

	string GraphName = StringByKey("WINDOW",infoStr)		//get the window name
	String event= StringByKey("EVENT",infoStr)

	strswitch (event)		//whats happenin'?

		case "Resize":

			ResizeToRect(GraphName)
			return 0
	endswitch

	return 0

end

Function ResizeToRect(GraphName)
	string GraphName

	variable Size

	GetWindow $GraphName wsize


	if((V_right-V_left)>(V_Bottom-V_Top))
		Size=(V_right-V_left)
	else
		Size=(V_Bottom-V_Top)
	endif

	NVAR XScanSize=root:ViewVariables:XScanSize
	NVAR YScanSize=root:ViewVariables:YScanSize

	MoveWIndow/W=$GraphName V_Left, V_Top, V_Left+Size, V_Top+Size*YScanSize/XScanSize

	//	NVAR ImageResize=root:ViewVariables:ImageResize
	//	ImageResize=1

End


Function ShowImage2ch(Process_flag)

	variable  Process_flag

	variable ret

	string SavedDataFolder = GetDataFolder(1)


	SetDataFolder root:ViewVariables

	variable Width, Height, Top,  ScreenNum

	FVScreenSize(Width,Height, ScreenNum)


	NVAR Process2ch=root:ImageProcessVariables:Process2ch
	Process2ch=Process_Flag

	variable ScrRes = 72/ScreenResolution		//probably unneeded



	Wave DisplayImage2ch=root:ViewVariables:DisplayImage2ch
	Wave RowDisplayImage2ch=root:ViewVariables:RowDisplayImage2ch

	if(WaveExists(DisplayImage2ch)==0)

		return 0

	endif

	//SetDataFolder root:ImageProcessVariables
	NVAR  CheckRemoveBG2ch=root:ImageProcessVariables:CheckRemoveBG2ch
	NVAR SetRemoveOrder2ch=root:ImageProcessVariables:SetRemoveOrder2ch
	NVAR CheckRemoveLineBG2ch=root:ImageProcessVariables:CheckRemoveLineBG2ch
	NVAR SetRemoveLineOrder2ch=root:ImageProcessVariables:SetRemoveLineOrder2ch
	NVAR CheckAllFilter2ch=root:ImageProcessVariables:CheckAllFilter2ch
	SVar SetFilterType2ch=root:ImageProcessVariables:SetFilterType2ch
	NVAR SetFilterNum2ch=root:ImageProcessVariables:SetFilterNum2ch

	NVAR XPixel=root:ViewVariables:XPixel
	NVAR YPixel=root:ViewVariables:YPixel
	NVAR OldYPixel=root:ImageProcessVariables:OldYPixel
	NVAR SizeChanged=root:ImageProcessVariables:SizeChanged

	NVAR CheckRemoveBG2ch=root:ImageProcessVariables:CheckRemoveBG2ch
	NVAR XScanSize=root:ViewVariables:XScanSize
	NVAR YScanSize=root:ViewVariables:YScanSize


	NVAR ImageIndex=root:ViewVariables:ImageIndex

	NVAR CrossFilterFlag=root:ViewVariables:CrossFilterFlag
	NVAR CrossFilterLevel=root:ViewVariables:CrossFilterLevel
	NVAR CrossFilterNum=root:ViewVariables:CrossFilterNum
	NVAR CheckFFT_Flag=root:ImageProcessVariables:CheckFFT_Flag


	////2016/9/15
	NVAR CheckOffFlatten2ch=root:ImageProcessVariables:CheckOffFlatten2ch
	NVAR CheckMedianFlatten2ch=root:ImageProcessVariables:CheckMedianFlatten2ch
	NVAR CheckMedianDifFlatten2ch=root:ImageProcessVariables:CheckMedianDifFlatten2ch
	NVAR CheckMeanFlatten2ch=root:ImageProcessVariables:CheckMeanFlatten2ch

	////

	NVAR CheckRemoveScars2ch= root:ImageProcessVariables:CheckRemoveScars2ch
	NVAR ScarsLength2ch= root:ImageProcessVariables:ScarsLength2ch


	NVAR CheckShowRange=root:ViewVariables:CheckShowRange
	NVAR TabMode=root:ViewVariables:TabMode

	// String ImageWaveName1ch=FileNameOnly(Name1ch)+"Image" //�g���q���폜


	if(Process_flag ==0)
		Duplicate/O DisplayImage2ch, RowDisplayImage2ch
	Endif



	//variable/G MaxData
	if(Process_flag !=0)

		DisplayImage2ch=RowDisplayImage2ch

	endif

	SetScale x, 0, XScanSize*1e-9, "m",DisplayImage2ch
	SetScale y ,0, XScanSize*YPixel/XPixel*1e-9,"m", DisplayImage2ch



	if(CheckRemoveBG2ch==1)

		Make/O/B/U/N=(Dimsize(DisplayImage2ch,0),Dimsize(DisplayImage2ch,1)) ROImask
		FastOP ROImask=1

		Duplicate/O DisplayImage2ch, RowDisplayImage2ch
		ImageRemoveBackGround/R=ROImask/O/P=(SetRemoveOrder2ch)  DisplayImage2ch



	endif

	if(CheckRemoveLineBG2ch==1 || CheckMedianFlatten2ch==1 || CheckMedianDifFlatten2ch==1 ||  CheckMeanFlatten2ch==1 )

		if(CheckRemoveLineBG2ch==1)
			ret=tu_Flatten(DisplayImage2ch, SetRemoveLineOrder2ch)
		endif

		if(CheckMedianFlatten2ch==1)

			FlattenMedian(DisplayImage2ch)

		elseif(CheckMedianDifFlatten2ch==1)

			FlattenMedianDif(DisplayImage2ch)

		elseif(CheckMeanFlatten2ch==1)

			FlattenMean(DisplayImage2ch)

		endif

	endif

	if(CheckRemoveScars2ch==1)

		RemoveScars(DisplayImage2ch, ScarsLength2ch)

	endif


	if(CheckFFT_Flag==1)

		MakeFFTImage2ch("root:ViewVariables:RowDisplayImage2ch")
		DoInvFFT2ch("root:ViewVariables:DisplayImage2ch")



	endif


	if(CrossFilterFlag==1)

		ret=tu_CrossFilter(DisplayImage2ch, CrossFilterNum,CrossFilterLevel)

	Endif

	if(CheckAllFilter2ch==1)

		DoFilter(SetFilterType2ch,SetFilterNum2ch, DisplayImage2ch)




	endif

	wave MyColors2ch=root:ViewVariables:myColors2ch

	WaveStats/Q DisplayImage2ch

	DoWindow Image2ch
	variable WindowCheck=V_flag



	if(WindowCheck==1)

		RemoveImage/Z/W=Image2ch  //$OldImageWaveName

		SizeChanged=0
		if(YPixel != OldYPixel)


			GetWindow Image2ch, wsize

			MoveWIndow/W=Image2ch height/3+10,10,height/3+10+height/3,height/3*YScanSize/XScanSize
			SizeChanged=1

		endif
	endif

	if(WindowCheck==0)
		variable Ratio

		NVAR SaveFlag

		if(CheckShowRange==0 && TabMode==1)

			NewImage/K=2/S=0/F/N=Image2ch DisplayImage2ch

		elseif((CheckShowRange==1 && TabMode==1) || TabMode==0)

			NewImage/K=2/S=2/F/N=Image2ch DisplayImage2ch

		endif

		MoveWIndow/W=Image2ch height/3+10,10,height/3+10+height/3,height/3*YScanSize/XScanSize


		SetWIndow Image2ch, hook=ImageHook



		ModifyImage DisplayImage2ch cindex=myColors2ch

	endif


	variable maxVal=WaveMAx(DisplayImage2ch)
	variable miniVal=WaveMin(DisplayImage2ch)

	SetScale/I x,miniVal,maxVal,myColors2ch



	/////

	NVAR Tabmode

	if(TabMode==0)
		ListBox  ImageList, activate, win=MainViewPanel
	endif

	SetDataFolder SavedDataFolder

End

Function CheckShowKilledFileProc(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked

	variable ret

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables

	if(checked==1)
		NewPanel /W=(0, 346, 261, 346)/K=2/HOST=EditPanel/EXT=0 as "Killed Files"
		String panelName = "EditPanel"+"#"+S_name
		//RenameWindow $panelName,  KilleFilesPanel
		//RenameWindow Killed Files, KilleFilesPanel"
		//DefineGuide UGH0={FT,25}
		//DefineGuide UGH1={UGH0,68}
		//DefineGuide UGH3={FB,-23}
		//DefineGuide UGH2={UGH3,-89}

		NVAR CheckSubFolder


		string KilledFileList
		variable countFileNum

		variable KilledFileNum


		variable i, j

		if(CheckSubFolder==1)

			PathInfo/S ParentFolderForSub

			String KilledFolderParent

			KilledFolderParent=S_Path

			KilledFileList= IndexedFile(ParentFolderForSub,-1,".asd_x")

			countFileNum=0

			KilledFileNum=0

			KilledFileNum=ItemsInList(KilledFileList, ";")

			Make/O/N=(KilledFileNum) KilledListBuddy
			Make/T/O/T/N=(KilledFileNum) KilledList
			Make/T/O/T/N=(KilledFileNum) KilledFolderList

			for(i=0;i<KilledFileNum; i+=1)
				KilledList[i]=StringFromList(i, KilledFileList)
				KilledListBuddy[i]=0
				KilledFolderList[i]=KilledFolderParent
				countFileNum+=1
			Endfor

			String SubFolder_All
			SubFolder_All=IndexedDir("ParentFolderForSub", -1, 0)
			variable FolderNum
			FolderNum=ItemsInList(SubFolder_All, ";")

			variable folder
			String CheckFolder

			for(folder=0; folder<FolderNum; folder+=1)

				CheckFolder=KilledFolderParent+ IndexedDir("ParentFolderForSub", folder, 0)

				NewPath/O/Q CheckKilledFilePath, CheckFolder

				KilledFileList = IndexedFile( CheckKilledFilePath,-1,".asd_x")

				KilledFileNum =ItemsInList(KilledFileList, ";")

				InsertPoints DimSize(KilledList,0), KilledFileNum, KilledList
				InsertPoints DimSize(KilledListBuddy,0), KilledFileNum, KilledListBuddy
				InsertPoints DimSize(KilledFolderList,0), KilledFileNum,KilledFolderList

				for(j=0;j<KilledFileNum;J+=1)
					KilledList[countFileNum]=StringFromList(j, KilledFileList)
					KilledListBuddy[countFileNum]=0
					KilledFolderList[countFileNum]=CheckFolder
					countFileNum+=1

				endfor

			endfor


		Endif

		if(CheckSubFolder==0)

			PathInfo/S ViewPath

			String KilledFolder

			KilledFolder=S_Path

			KilledFileList= IndexedFile(ViewPath,-1,".asd_x")

			KilledFileNum=ItemsInList(KilledFileList, ";")

			Make/O/N=(KilledFileNum) KilledListBuddy
			Make/T/O/T/N=(KilledFileNum) KilledList
			Make/T/O/T/N=(KilledFileNum) KilledFolderList

			for(i=0;i<KilledFileNum; i+=1)
				KilledList[i]=StringFromList(i, KilledFileList)
				KilledListBuddy[i]=0
				KilledFolderList[i]=KilledFolder
				countFileNum+=1
			Endfor


		Endif

		KilledListBuddy[0]=1

		ListBox KilledFileList,win= EditPanel#P0, font="Arial",fsize=10,frame=2,mode=4,selWave=root:ViewVariables:KilledListBuddy
		ListBox KilledFileList,win= EditPanel#P0,  pos={15,15},listWave=root:ViewVariables:KilledList,size={250,230}, proc=KilledListFuncAction

		String/G  textKilledFilaPath
		TitleBox ShowKilledFolder,win=EditPanel#P0, fsize=11, pos={15,260},size={200,100},frame=0, variable=textKilledFilaPath
		textKilledFilaPath =KilledFolderList[0]

		Button ButtonRestoreFile, win=EditPanel#P0,  pos={90,300},size={80,30},title="Restore", proc=ButtonRestoreFileProc//, fcolor=(1,1,1)



	else

		KillWIndow EditPanel#P0

		KillPath/Z CheckKilledFilePath

	endif

	SetDataFolder SavedDataFolder

End

Function CheckInvertProc(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked

	ShowImage(0)

end

Function Check2chShowProc(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked

	variable ret

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables


	NVAR DataType2ch=root:ViewVariables:DataType2ch
	NVAR XPixel=root:ViewVariables:XPixel
	NVAR YPixel=root:ViewVariables:YPixel

	NVAR DataVer=root:ViewVariables:DataVer

	NVAR CheckSwapChFlag=root:ViewVariables:CheckSwapChFlag

	Wave DisplayImage=root:ViewVariables:DisplayImage
	Wave DisplayImage2ch=root:ViewVariables:DisplayImage2ch

	if(checked==0)
		DoWindow Image2ch
		if(V_Flag==1)
			DoWindow/k Image2ch
		endif

		CheckBox  SwapChCheck,win=MainViewPanel, disable=1

	endif

	if(checked==1)


		if(DataType2ch !=0)
			Make/O/N=(XPixel, YPixel)  DisplayImage2ch

			DoWindow Image2ch

			ret=tu_DisplayIndexedImage()
			if(ret==1)
				DoAlert 1, "Error: td_DisplayIndexedImage"
				return 0
			endif

			if(CheckSwapChFlag==1)

				Duplicate/O DisplayImage TempSwapImage

				Duplicate/O DisplayImage2ch DisplayImage

				Duplicate/O TempSwapImage DisplayImage2ch

				KIllWaves TempSwapImage

			endif



			ShowImage(0)
			ShowImage2ch( 0)

		endif

		CheckBox  SwapChCheck,win=MainViewPanel, disable=0

	endif


	SetDataFolder SavedDataFolder

End

Function CheckSwapChProc(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked

	ShowImage(0)
	ShowImage2ch(0)

end

Function CheckShowCBarProc(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked

	variable ret

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables



	if(checked==0)
		DoWindow ColorBarPanel
		if(V_Flag==1)
			DoWindow/k ColorBarPanel
		endif
	endif

	if(checked==1)


		ShowColorBar()

	endif



	SetDataFolder SavedDataFolder

End


Function CheckCrossFilterProc(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables

	Wave DisplayImage
	Wave RowDisplayImage

	NVAR DataType1ch
	NVAR DataType2ch
	NVAR  Show2chFlag

	if(checked==0)

		SetVariable setvarLevel, disable=1
		SetVariable setvarNum, disable=1

		Duplicate/O RowDisplayImage DisplayImage

		if(WaveExists(DisplayImage)   !=0)
			//	if(DataType2ch ==0 || Show2chFlag==0)
			ShowImage(1)
			//	endif
			//			if(DataType2ch !=0 && Show2chFlag==1)
			//				ShowImage( 1)
			//				ShowImage2ch( 1)
			//			endif
		endif


	endif

	if(checked==1)
		SetVariable setvarLevel, disable=0
		SetVariable setvarNum, disable=0

		if(WaveExists(DisplayImage)   !=0)
			//if(DataType2ch ==0 || Show2chFlag==0)
			ShowImage( 0)
			//	endif
			//	if(DataType2ch !=0 && Show2chFlag==1)
			//		ShowImage( 0)
			//		ShowImage2ch( 0)
			//	endif
		endif

	endif





	SetDataFolder SavedDataFolder

End

Function SetCrossFilterLevelProc(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables

	Wave DisplayImage

	NVAR DataType1ch
	NVAR DataType2ch
	NVAR  Show2chFlag

	if(WaveExists(DisplayImage)   !=0)
		//if(DataType2ch ==0 || Show2chFlag==0)
		ShowImage( 1)
		//endif
		//if(DataType2ch !=0 && Show2chFlag==1)
		//	ShowImage( 1)
		//	ShowImage2ch(1)
		//endif
	endif

	SetDataFolder SavedDataFolder

End


Function SetCrossFilterNumProc(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables

	Wave DisplayImage

	NVAR DataType1ch
	NVAR DataType2ch
	NVAR  Show2chFlag

	if(WaveExists(DisplayImage)   !=0)
		//if(DataType2ch ==0 || Show2chFlag==0)
		ShowImage( 1)
		//endif
		//if(DataType2ch !=0 && Show2chFlag==1)
		//	ShowImage(1)
		//	ShowImage2ch(1)
		//endif
	endif

	SetDataFolder SavedDataFolder


End


Function SetIndexProc(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName

	variable ret

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables


	Wave ImageListBuddy=root:ViewVariables:ImageListBuddy
	Wave ImageList=root:ViewVariables:ImageList

	NVAR ImageIndex=root:ViewVariables:ImageIndex
	NVAR ImageFileIndex=root:ViewVariables:ImageFileIndex
	NVAR FileNum=root:ViewVariables:FileNum
	NVAR FrameNum=root:ViewVariables:FrameNum
	NVAR DataVer=root:ViewVariables:DataVer
	NVAR DataType2ch=root:ViewVariables:DataType2ch
	NVAR Show2chFlag=root:ViewVariables:Show2chFlag
	NVAR CheckSwapChFlag=root:ViewVariables:CheckSwapChFlag

	Wave DisplayImage=root:ViewVariables:DisplayImage
	Wave DisplayImage2ch=root:ViewVariables:DisplayImage2ch


	if(WaveExists(ImageList)==0)
		return 0
	endif


	WaveStats/Q ImageListBuddy

	if(V_max==0)
		return 0

	endif

	ret=tu_DisplayIndexedImage()
	if(ret==1)
		DoAlert 1, "Error: td_DisplayIndexedImage"
		return 0
	endif

	if(CheckSwapChFlag==1)

		Duplicate/O DisplayImage TempSwapImage

		Duplicate/O DisplayImage2ch DisplayImage

		Duplicate/O TempSwapImage DisplayImage2ch

		KIllWaves TempSwapImage

	endif

	NVAR Process=root:ImageProcessVariables:Process
	process=0




	if(DataType2ch ==0 || Show2chFlag==0)
		ShowImage(0)
	endif
	if(DataType2ch !=0 && Show2chFlag==1)
		ShowImage(0)
		ShowImage2ch( 0)
	endif




	SetDataFolder SavedDataFolder


End


Function SetMovieSizeProc(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables

	NVAR MovieSize

	DoWIndow/F Image1ch
	DoAutoSizeImageFalcon( MovieSize,1)

	SetDataFolder SavedDataFolder

End



Function ImageFileOpen()

	variable FileVer

	variable ret

	string SavedDataFolder = GetDataFolder(1)


	SetDataFolder root:ViewVariables

	NVAR DataType1ch=root:ViewVariables:DataType1ch
	NVAR DataType2ch=root:ViewVariables:DataType2ch

	NVAR Show2chFlag=root:ViewVariables:Show2chFlag

	NVAR ImageFileIndex

	NVAR DataVer=root:ViewVariables:DataVer

	NVAR SliderSetFlag

	SliderSetFlag=0
	SetDrawLayer/W=MainViewPanel/K USerFront



	Wave/T ImageList=root:ViewVariables:ImageList

	Wave/T FolderList=root:ViewVariables:FolderList



	SVAR FileName

	FileName=ImageList[ImageFileIndex]


	SVAR ImageFilePath=root:ViewVariables:ImageFilePath

	SVAR Path=root:ViewVariables:Path

	NVAR CheckSubFolder

	if(CheckSubFolder==1)

		NewPath/O/Q/Z ViewPath, FolderList[ImageFileIndex]

	endif

	PathInfo ViewPath

	Path=S_Path

	ImageFilePath=Path

	ConvertGlobalStringTextEncoding/CONV=4 1,4, ImageFilePath

	if( stringmatch(FileName, "*daf" )==1)
		FileVer=0
	elseif( stringmatch(FileName, "*asd" )==1)
		FileVer=1
	endif

	if(FileVer==1)

		//  OpenNewData()

		ret=tu_OpenNewFile()

		if(ret==1)

			return 0

		endif

		OpenString()

		CheckEditPanel()
	else

		return 0

	endif

	SVAR TextDisplayStringPath=root:ViewVariables:TextDisplayStringPath

	Make/T/O textOutputWave
	Wave/T  textOutputWave=root:ViewVariables:textOutputWave


	ConvertGlobalStringTextEncoding/CONV=4 4,1, ImageFilePath

   textDisplayStringPath = WrapText(ImageFilePath, 50)//WordWrapControlText(ImageFilePath, textOutputWave, "MainViewPanel", "ShowDataFolder", "groupDataFolder", firstLineNum = 0)


	NVAR ImageIndex

	SetSlider()
	Button buttonSetImage,win=MainViewPanel,disable=0


	NVAR FrameNum=root:ViewVariables:FrameNum
	SetVariable SetIndex, win=MainViewPanel,limits={0,FrameNum-1,1}, value=$"root:ViewVariables:ImageIndex"



	NVAR Process=root:ImageProcessVariables:Process
	process=0

	if(DataType2ch ==0 || Show2chFlag==0 )
		ShowImage(0)
	endif
	if(DataType2ch !=0 && Show2chFlag==1 )
		ShowImage(0)
		ShowImage2ch( 0)
	endif


	//	DoWIndow/K  WMImageRangeGraph
	//	DoWindow WMImageRangeGraph
	//	if(V_Flag==1)
	//		WMCreateImageRangeGraph_F()
	//	endif

	DOWindow/F MainViewPanel


	//

	DoUpDate

	NVAR FirstFrame
	NVAR LastFrame
	FirstFrame=0
	LastFrame=FrameNum-1


	SetDatafolder SavedDataFolder


End

Function OpenString()

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables

	variable refnum
	SVAR FileName
	SVAR Comment=root:ViewVariables:Comment
	SVAR OpeName=root:ViewVariables:OpeName

	NVAR  FileType=root:ViewVariables:FileType
	NVAR  OpeNameSize=root:ViewVariables:OpeNameSize
	NVAR CommentSize=root:ViewVariables:CommentSize
	NVAR CommentOffset=root:ViewVariables:CommentOffset
	NVAR  FileHeaderSize=root:ViewVariables:FileHeaderSize

	NVAR Year, Month, Day, Hour, Minute, Second
	SVAR CapturedDate

	CapturedDate=num2Str(Year)+"/"+num2str(Month)+"/"+num2str(Day)+"  "+num2Str(Hour)+":"+num2str(Minute)+":"+num2Str(Second)

	Open/Z=2/R/P=ViewPath/T=".asd" refnum as FileName


	if(FileType==0)

		FSetPos refnum,FileHeaderSize-OpeNameSize-12

		String Temp
		Temp=""
		Temp=padstring("", OpeNameSize,OpeNameSize)
		//PadString(, 0, OpeNameSize )
		FBinRead/B=2 refnum,Temp
		variable i

		OpeName=""
		for(i=0;i<OpeNameSize/2;i+=1)

			OpeName+=Temp[i*2+1]

		Endfor

		FSetPos refnum,FileHeaderSize+CommentOffset
		Temp=padstring("", CommentSize,CommentSize)


		FBinRead/B=2 refnum,Temp

		Comment=""
		for(i=0;i<CommentSize/2;i+=1)

			Comment+=Temp[i*2+1]

		Endfor


	endif



	if(FileType==1)

		FSetPos refnum,FileHeaderSize-CommentSize-OpeNameSize

		OpeName=padstring("", OpeNameSize,OpeNameSize)
		//PadString(, 0, OpeNameSize )
		FBinRead refnum,OpeName

		ConvertGlobalStringTextEncoding/CONV=4 4,1 , OpeName

		Comment=padstring("", CommentSize,CommentSize)
		FBinRead refnum,Comment


		ConvertGlobalStringTextEncoding/CONV=4 4,1 , Comment

	endif



	Close refnum

	//Comment
	//Wave/T  textOutputWave=root:ViewVariables:textOutputWave
	//SVAR TextDisplayStringComment=root:ViewVariables:TextDisplayStringComment
	//textDisplayStringComment = WordWrapControlText(Comment, textOutputWave, "MainViewPanel", "ShowComment", "CommentGroup", firstLineNum = 0)

	SVAR Comment=root:ViewVariables:Comment

	//GetFileFolderInfo/P=FalconViewerPath/Q/Z   "CommentNote.txt"

	//if(V_flag==0)
	//  DeleteFile/P=FalconViewerPath /Z=1  "CommentNote.txt"
	//endif

	//SaveNotebook/O/P=FalconViewerPath/S=6  EditPanel#CommentNote  as "CommentNote.txt"
	//NoteBook MainViewPanel#CommentNote selection={StartOfFile, endOfFile}
	//GetSelection notebook,  EditPanel#CommentNote, 2
	//NoteBook MainViewPanel#CommentNote text=Comment

	//KillWIndow MainViewPanel#CommentNote ///W=(CurrentLeft+5,CurrentTop+15,CurrentLeft+5+280,CurrentTop+123)/OPTS=4 as "CommentNote"

	//NewNotebook/ENCG=4/F=1 /N=CommentNote /HOST=MainViewPanel /W=(490+5,10+15,490+5+280,10+123)/OPTS=4 as "CommentNote"

	NoteBook MainViewPanel#CommentNote selection={startOfFile, EndOfFile }
	NoteBook MainViewPanel#CommentNote text=""

	NoteBook MainViewPanel#CommentNote text=Comment, magnification=1, selection={startOfFile, startOfFile }
	NoteBook MainViewPanel#CommentNote text=""


	SetDatafolder SavedDataFolder

End

Function ButtonMakeMovieCheckProc(ctrlName) : ButtonControl
	String ctrlName



	string SavedDataFolder = GetDataFolder(1)
	SetDataFolder root:ViewVariables

	NVAR DataType2ch
	NVAR Show2chFlag
	NVAR MovieChannel
	NVAR Check3DSave

	variable WhichMovie=0

	MakeMovieConfigPanel()

	return 0

	if(WinType("wm_tmpGizmoMovieWindow")!=0 && Check3DSave==1)

		//DoAlert/T="3D View is displayed!" 1, "Do you want to make 3D movie?"

		//if(v_flag==1)

		whichMovie=1

		Make3DMovie()

		return 0
		//endif

	endif
	//
	//	if(DataType2ch !=0 && Show2chFlag==1)
	//
	//		PauseUpdate; Silent 1		// building window...
	//		NewPanel /W=(514,135,722,218)/k=2 as "Select Channel"
	//		DoWindow/C/T MovieSelectPanel, "Select Channel"
	//
	//		PopupMenu popupChannel,pos={47,14},size={102,20},title="Channel"
	//		PopupMenu popupChannel,mode=1,popvalue="1ch",value= #"\"1ch;2ch\"",proc=PopMovieChannelProc
	//		Button buttonMovieChannelOK,pos={64,49},size={73,27},title="Go!", Proc=ButtonGoMakeMovieProc
	//
	//	else
	MovieChannel=1
	MakeMovie()
	//endif


	SetDatafolder SavedDataFolder

End

Function PopMovieChannelProc(pa) : PopupMenuControl
	STRUCT WMPopupAction &pa

	NVAR MovieChannel= root:ViewVariables:MovieChannel

	switch( pa.eventCode )
		case 2: // mouse up
			Variable popNum = pa.popNum
			String popStr = pa.popStr

			MovieChannel=popNum

			break
	endswitch

	return 0
End

Function MakeMovieConfigPanel()


	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables

	DoWIndow/F MovieConfigPanel
	if(v_flag==1)

	 return 0

	endif

	PauseUpdate; Silent 1		// building window...

	NewPanel/k=2/W=(564,80,833,274) as "Movie Configulation Panel"
	DoWindow/C/T MovieConfigPanel "Movie Configulation Panel"

	//MoveWIndow TrackingPanel  350, 50, 350+

	Wave MovieConfigPanelParams=root:MovieConfigP

	MoveWindow/W=MovieConfigPanel MovieConfigPanelParams[0],MovieConfigPanelParams[1], MovieConfigPanelParams[2], MovieConfigPanelParams[3]

   	NVAR FrameRate
	NVAR CompFactor
	NVAR MovieFormat

	NVAR FrameTime
	FrameRate =1/FrameTime*10^3

	SetVariable setCompression,win=MovieConfigPanel, pos={40.00,15.00},size={184.00,18.00},title="Compression Factor", value=$"root:ViewVariables:CompFactor"
	PopupMenu popupMovType,win=MovieConfigPanel,pos={40.00,50.00},size={124.00,19.00},title="Movie Format "
	PopupMenu popupMovType,win=MovieConfigPanel,mode=MovieFormat,value= #"\"mp4;avi\"", proc=PopMovieFormatProc
	SetVariable setvarFrameRate,win=MovieConfigPanel,limits={0.1,60,1}, pos={40.00,83.00},size={184.00,18.00},title="Frame Rate (fps)", value=$"root:ViewVariables:FrameRate",proc=SetMovieFrameProc
	Button buttonMovieOK,win=MovieConfigPanel,pos={84.00,126.00},size={103.00,32.00},title="OK", proc=ButtonMakeMovieProc

End

//Function PopMovieTypeProc(pa) : PopupMenuControl
//	STRUCT WMPopupAction &pa
//
//	switch( pa.eventCode )
//		case 2: // mouse up
//			Variable popNum = pa.popNum
//			NVAR Movie_Type= root:ViewVariables:Movie_Type
//
//			Movie_Type=popNum
//
//			break
//	endswitch
//
//	return 0
//
//
//
//	return 0
//End


//Function ButtonGoMakeMovieProc(ba) : ButtonControl
//	STRUCT WMButtonAction &ba
//
//	switch( ba.eventCode )
//		case 2: // mouse up
//			// click code here
//
//			KillWindow MovieSelectPanel
//			MakeMovie()
//
//
//			break
//	endswitch
//
//	return 0
//End
//

Function ButtonMakeMovieProc(ba) : ButtonControl
	STRUCT WMButtonAction &ba

	string SavedDataFolder = GetDataFolder(1)
	SetDataFolder root:ViewVariables

	NVAR Check3DSave

	switch( ba.eventCode )
		case 2: // mouse up
			// click code here

			KillWindow MovieConfigPanel

			if(WinType("wm_tmpGizmoMovieWindow")!=0 && Check3DSave==1)

			Make3DMovie()

			return 0

			endif

			MakeMovie()


			break
	endswitch

	return 0
End


Function MakeMovie()

	variable ret

	string SavedDataFolder = GetDataFolder(1)
	SetDataFolder root:ViewVariables



	NVAR SaveModeFlag
	NVAR SaveFlag

	SVAR FileName
	NVAR ImageIndex
	NVAR ImageNum
	NVAR FrameNum

	NVAR XPixel
	NVAR YPixel

	NVAR DataType2ch
	NVAR Show2chFlag

	SVAR SaveFilePath
	SVAR SaveFileName


	NVAR FrameTime
	//NVAR MovieSpeed

	NVAR FirstFrame
	NVAR LastFrame

	NVAR AutoViewSpeed

	NVAR MovieSize
	//NVAR Movie_Type


	NVAR DataType2ch, Show2chFlag

	NVAR CheckSwapChFlag

	Wave DisplayImage
	Wave DisplayImage2ch

   NVAR FrameRate
   NVAR CompFactor
   NVAR MovieFormat

	NVAR percentFinished

	NVAR MovieChannel

	variable currentIndex

	CurrentIndex=ImageIndex


	SaveFlag=1

	variable Frameloop
	variable Frames_per_Second

	Frameloop=1

	Frames_per_Second = floor(FrameRate)

	if(FrameRate <1)

	Frameloop=floor(1/FrameRate)

	endif

	if(FrameRate <1)

	Frames_per_Second=1

	endif

	variable MovieFolderFlag

	variable index
	String BaseName
	String MovieSavePath


	variable SaveFloderFlag

	DoAlert/T="Which folder do you want to save?" 1, "Original folder?"

	if(v_flag==1)

		SaveFloderFlag=0
	else

		PathInfo MoviePath

		if(V_Flag==0)

			DoAlert/T="Warning!" 0, "Set the folder"

			return 0

		else

			SaveFloderFlag=1

		endif

	endif



	variable mloop

	if(SaveModeFlag==1 )  // Single File


		NVAR DataType2ch, Show2chFlag

		//if( (DataType2ch ==0 || Show2chFlag==0))
		DoWIndow/K Image1ch
		//endif
		//if((DataType2ch !=0 && Show2chFlag==1) )
		//	DoWIndow/K Image1ch
		//	DoWIndow/K Image2ch
		//endif


		BaseName=FileNameOnly(FileName)

		if(MovieFormat ==1)

			if(SaveFloderFlag==0)
				Open/D/P=ViewPath/T=".mp4"/M="Select Folder and Type BaseName" refnum as BaseName
			else
				Open/D/P=MoviePath/T=".mp4"/M="Select Folder and Type BaseName" refnum as BaseName
			endif

		elseif(MovieFormat ==2)

			if(SaveFloderFlag==0)
				Open/D/P=ViewPath/T=".avi"/M="Select Folder and Type BaseName" refnum as BaseName
			else
				Open/D/P=MoviePath/T=".avi"/M="Select Folder and Type BaseName" refnum as BaseName
			endif

		endif

		strswitch(S_FileName)
			case "":

				ret=tu_DisplayIndexedImage()
				if(ret==1)
					DoAlert 1, "Error: td_DisplayIndexedImage"
					return 0
				endif


				if(CheckSwapChFlag==1)

					Duplicate/O DisplayImage TempSwapImage

					Duplicate/O DisplayImage2ch DisplayImage

					Duplicate/O TempSwapImage DisplayImage2ch

					KIllWaves TempSwapImage

				endif

				ShowImage(0)
				return 0
		endswitch

		SaveFilePath=RemoveFromList(StringFromList(ItemsInList(S_FileName, ":")-1, S_FileName, ":"), S_FileName, ":")

		NewPath/O/Q SaveImagePath, SaveFilePath

		MovieSavePath=S_FileName



		for(index=0;index<FrameNum;index+=1)

			for (mloop=0; mloop<Frameloop;mloop +=1)

				ImageIndex=index

				if(index==0)
					DoWIndow ProgressBar
					if(V_flag==0)
						pnlProgress()
					endif
				endif

				if(index==FrameNum-1)
					DoWIndow/K/Z ProgressBar
				endif

				percentFinished=index*100/FrameNUm
				DoUpDate

				ret=tu_DisplayIndexedImage()
				if(ret==1)
					DoAlert 1, "Error: td_DisplayIndexedImage"
					return 0
				endif

				if(CheckSwapChFlag==1)

					Duplicate/O DisplayImage TempSwapImage

					Duplicate/O DisplayImage2ch DisplayImage

					Duplicate/O TempSwapImage DisplayImage2ch

					KIllWaves TempSwapImage

				endif

				ShowImage(0)

				NVAR TimeFlag=root:ViewVariables:TimeFlag

				if(TimeFlag==1)
					AddTimeCap(index)
				endif

				NVAR ScaleFlag=root:ViewVariables:ScaleFlag
				NVAR FileNameFlag=root:ViewVariables:FileNameFlag

				if(index ==0 && mloop==0)
					if(ScaleFlag==1)
						AddScaleCapFirst()
					endif
					if(FileNameFlag==1)

						AddFileNameCapFirst()

					endif
				elseif(index ==1)
					if(ScaleFlag==1)
						SetDrawLayer/W=Image1ch/K USerFront
					endif
					if(FileNameFlag==1)
						TextBox/w=Image1ch/K/N=textFileName
					endif
				endif


				////For Laser Flag

				//AddLaserBox()

				////
				///

				DoWIndow/F Image1ch


				if(index==0 && mloop==0)

					DoAutoSizeImageFalcon(MovieSize,1)

					switch(MovieFormat)

					case 1:
						NewMovie/CF=(CompFactor)/Z/O/F=(Frames_per_Second)  as MovieSavePath

						break
					case 2:
					   NewMovie/CF=(CompFactor)/Z/O/F=(Frames_per_Second)/A  as MovieSavePath

					   break

					endswitch

					if(V_flag !=0)
						DoWIndow/K/Z ProgressBar

						ImageIndex=CurrentIndex

						SaveFlag=0
						DoWIndow/K Image1ch

						tu_DisplayIndexedImage()


						if(CheckSwapChFlag==1)

							Duplicate/O DisplayImage TempSwapImage

							Duplicate/O DisplayImage2ch DisplayImage

							Duplicate/O TempSwapImage DisplayImage2ch

							KIllWaves TempSwapImage

						endif

						ShowImage(0)

						return 0
					endif

				endif


				AddMovieFrame

			Endfor

		endfor

		CloseMovie

		SaveFlag=0
		DoWIndow/K Image1ch

		ImageIndex=CurrentIndex

		ret=tu_DisplayIndexedImage()
		if(ret==1)
			DoAlert 1, "Error: td_DisplayIndexedImage"
			return 0
		endif

		if(CheckSwapChFlag==1)

			Duplicate/O DisplayImage TempSwapImage

			Duplicate/O DisplayImage2ch DisplayImage

			Duplicate/O TempSwapImage DisplayImage2ch

			KIllWaves TempSwapImage

		endif


	Endif


	if(SaveModeFlag==2 )  // Limited Frames


		NVAR DataType2ch, Show2chFlag


		DoWIndow/K Image1ch

		BaseName=FileNameOnly(FileName)+"_"+num2str(FirstFrame)+"_"+num2str(LastFRame)

		if(MovieFormat ==1)

			if(SaveFloderFlag==0)
				Open/D/P=ViewPath/T=".mp4"/M="Select Folder and Type BaseName" refnum as BaseName
			else
				Open/D/P=MoviePath/T=".mp4"/M="Select Folder and Type BaseName" refnum as BaseName
			endif

		elseif(MovieFormat ==2)

			if(SaveFloderFlag==0)
				Open/D/P=ViewPath/T=".avi"/M="Select Folder and Type BaseName" refnum as BaseName
			else
				Open/D/P=MoviePath/T=".avi"/M="Select Folder and Type BaseName" refnum as BaseName
			endif

		endif



		strswitch(S_FileName)
			case "":

				ret=tu_DisplayIndexedImage()
				if(ret==1)
					DoAlert 1, "Error: td_DisplayIndexedImage"
					return 0
				endif


				if(CheckSwapChFlag==1)

					Duplicate/O DisplayImage TempSwapImage

					Duplicate/O DisplayImage2ch DisplayImage

					Duplicate/O TempSwapImage DisplayImage2ch

					KIllWaves TempSwapImage

				endif

				ShowImage(0)

				return 0
		endswitch

		SaveFilePath=RemoveFromList(StringFromList(ItemsInList(S_FileName, ":")-1, S_FileName, ":"), S_FileName, ":")

		NewPath/O/Q SaveImagePath, SaveFilePath



		MovieSavePath=S_FileName


		for(index=FirstFrame;index<=LastFrame;index+=1)

			for (mloop=0; mloop<Frameloop;mloop +=1)
				ImageIndex=index

				if(index==FirstFrame)
					DoWIndow ProgressBar
					if(V_flag==0)
						pnlProgress()
					endif
				endif

				if(index==LastFrame-1)
					DoWIndow/K/Z ProgressBar
				endif

				percentFinished=index*100/(LastFrame-FirstFrame)
				DoUpDate

				ret=tu_DisplayIndexedImage()
				if(ret==1)
					DoAlert 1, "Error: td_DisplayIndexedImage"
					return 0
				endif


				if(CheckSwapChFlag==1)

					Duplicate/O DisplayImage TempSwapImage

					Duplicate/O DisplayImage2ch DisplayImage

					Duplicate/O TempSwapImage DisplayImage2ch

					KIllWaves TempSwapImage

				endif


				ShowImage(0)

				DoWIndow/F Image1ch

				NVAR TimeFlag=root:ViewVariables:TimeFlag
				if(TimeFlag==1)
					AddTimeCap( index)
				endif

				NVAR ScaleFlag=root:ViewVariables:ScaleFlag
				NVAR FileNameFlag=root:ViewVariables:FileNameFlag
				if(index ==FirstFrame && mloop==0)
					if(ScaleFlag==1)
						AddScaleCapFirst()
					endif

					if(FileNameFlag==1)
						AddFileNameCapFirst()

					endif

				elseif( index ==FirstFrame+1)
					if(ScaleFlag==1)
						SetDrawLayer/W=Image1ch/K USerFront
					endif
					if(FileNameFlag==1)
						TextBox/w=Image1ch/K/N=textFileName
					endif

				endif


				if(index==FirstFrame && mloop==0)

					DoAutoSizeImageMovie( MovieSize,1, MovieChannel)

					switch(MovieFormat)

					case 1:
						NewMovie/CF=(CompFactor)/Z/O/F=(Frames_per_Second)  as MovieSavePath

						break
					case 2:
					   NewMovie/CF=(CompFactor)/Z/O/F=(Frames_per_Second)/A  as MovieSavePath

					   break

					endswitch



					if(V_flag !=0)
						DoWIndow/K/Z ProgressBar

						ImageIndex=CurrentIndex

						SaveFlag=0

						ShowImage(0)

						return 0
					endif

				endif

				DoAutoSizeImageMovie( MovieSize,1, 1)
				AddMovieFrame

			Endfor

		endfor

		CloseMovie

		SaveFlag=0


		DoWIndow/K Image1ch

		ImageIndex=CurrentIndex

		ret=tu_DisplayIndexedImage()
		if(ret==1)
			DoAlert 1, "Error: td_DisplayIndexedImage"
			return 0
		endif


		if(CheckSwapChFlag==1)

			Duplicate/O DisplayImage TempSwapImage

			Duplicate/O DisplayImage2ch DisplayImage

			Duplicate/O TempSwapImage DisplayImage2ch

			KIllWaves TempSwapImage

		endif

	Endif

		ShowImage(0)

		NVAR TimeFlag=root:ViewVariables:TimeFlag
		if(TimeFlag==1)
			AddTimeCapFirst()
		endif

		NVAR ScaleFlag=root:ViewVariables:ScaleFlag
		NVAR FileNameFlag=root:ViewVariables:FileNameFlag

		if(ScaleFlag==1)
			AddScaleCapFirst()
		endif

		if(FileNameFlag==1)
			AddFileNameCapFirst()
		endif

		DoWIndow/K/Z ProgressBar

	DoAutoSizeImageFalcon(MovieSize,1)

	if(WinType("wm_tmpGizmoMovieWindow")!=0)
		DoWIndow/K wm_tmpGizmoMovieWindow
	endif


	NVAR InfoFlag
	if( InfoFlag==1)
		InfoFlag=0
		DoWIndow/K CaptionPanel
	endif


	Dowindow ColorBarPanel

	if(V_Flag==1)

		SavePICT/E=-4/Win=ColorBarPanel

	endif

	SetDataFolder SavedDataFolder

End


Function DoAutoSizeImageMovie(forceSize,flipVert, Channel)
	variable forceSize,flipVert, Channel

	if( (forceSize != 0) )
		if( (forceSize<0.1) %| (forceSize>20) )
			Abort "Unlikey value for forceSize; usually 0 or between .1 and 20"
			return 0
		endif
	endif

	String imagename

	if(Channel==1)
		imagename="DisplayImage;"
	else
		imagename="DisplayImage2ch;"
	endif
	//String imagename= ImageNameList("", ";")
	Variable p1= strsearch(imagename, ";", 0)
	if( p1 <= 0 )
		Abort "Graph contains no images"
		return 0
	endif

	// Remember input for next time
	String dfSav= GetDataFolder(1);
	NewDataFolder/O/S root:Packages
	NewDataFolder/O/S WMAutoSizeImages
	Variable/G forceSizeSav= forceSize
	Variable/G flipVertSav= flipVert
	SetDataFolder dfSav

	NVAR XScanSize=root:ViewVariables:XScanSize
	NVAR YScanSize=root:ViewVariables:YScanSize

	imagename= imagename[0,p1-1]
	Wave w= ImageNameToWaveRef("",imagename)

	Variable width= DimSize(w,0)
	Variable height= width*YScanSize/XScanSize //DimSize(w,1)

	do
		if( forceSize )
			height *= forceSize;
			width *= forceSize;
			break
		endif
		variable maxdim= max(height,width)
		NewDataFolder/S tmpAutoSizeImage
		Make/O sizes={20,50,100,200,600,1000,2000,10000,50000,100000}		// temp wavesused as lookup tables
		Make/O scales={16,8,4,2,1,0.5,0.25,0.125,0.0626,0.03125}
		Variable nsizes= numpnts(sizes),scale= 0,i= 0
		do
			if( maxdim < sizes[i] )
				scale= scales[i]
				break;
			endif
			i+=1
		while(i<nsizes)
		KillDataFolder :			// zap our two temp waves that were used as lookup tables
		if( scale == 0 )
			Abort "Image is bigger than planed for"
			return 0
		endif
		width *= scale;
		height *= scale;
	while(0)

	String axname= ImageInfo("",imagename,0)
	Variable p0= strsearch(axname, "YAXIS:", 0)
	p0=  strsearch(axname, ":", p0)
	p1=  strsearch(axname, ";", p0)
	if( flipVert != -1 )
		if( flipVert )
			SetAxis/A $(axname[p0+1,p1-1])
		else
			SetAxis/A/R $(axname[p0+1,p1-1])
		endif
	endif
	width *= 72/ScreenResolution					// make image pixels match screen pixels
	height *= 72/ScreenResolution					// make image pixels match screen pixels
	ModifyGraph width=width,height=height
	DoUpdate
	if( forceSize==0 )
		ModifyGraph width=0,height=0
	endif
end




Function ButtonSaveProc(ctrlName) : ButtonControl
	String ctrlName

	variable ret

	string presuffix

	String BaseName
	variable index


	variable refnum

	string SavedDataFolder = GetDataFolder(1)
	SetDataFolder root:ViewVariables


	NVAR SaveBMPFlag
	NVAR SaveJPEGFlag
	NVAR SaveTIFFFlag
	NVAR SaveBCRFlag
	NVAR SaveASDFlag
	NVAR SaveModeFlag
	NVAR SaveFlag

	SVAR FileName
	NVAR ImageIndex
	NVAR ImageNum
	NVAR FrameNum

	NVAR XPixel
	NVAR YPixel

	NVAR DataType2ch
	NVAR Show2chFlag

	SVAR SaveFilePath
	SVAR SaveFileName

	NVAR percentFinished

	SaveFlag=1

	String SaveFileName_Base

	NVAR  RecordedIndex

	variable SaveFloderFlag

	NVAR CheckSwapChFlag

	Wave DisplayImage
	Wave DisplayImage2ch

	DoAlert/T="Which folder do you want to save?" 1, "Original folder?"

	if(v_flag==1)

		SaveFloderFlag=0
	else

		PathInfo PICPath

		if(V_Flag==0)

			DoAlert/T="Warning!" 0, "Set the folder"

			return 0

		else

			SaveFloderFlag=1

		endif

	endif



	RecordedIndex=ImageIndex


	if(SaveModeFlag==1 &&   (SaveBMPFlag==1 || SaveJPEGFlag==1 || SaveTIFFFlag==1 || SaveBCRFlag==1))  // Single File

		NVAR FrameNum

		BaseName=FileNameOnly(FileName)+"_"

		if(SaveFloderFlag==0)
			Open/D/P=ViewPath/F="*.*"/M="Select Folder and Type BaseName" refnum as BaseName
		else
			//Open/D/P=PICPath/T="????"/M="Select Folder and Type BaseName" refnum as BaseName
			Open/D/P=PICPath/F="*.*"/M="Select Folder and Type BaseName" refnum as BaseName
		endif

		strswitch(S_FileName)
			case "":
				return 0
		endswitch

		SaveFilePath=RemoveFromList(StringFromList(ItemsInList(S_FileName, ":")-1, S_FileName, ":"), S_FileName, ":")

		NewPath/O/Q SaveImagePath, SaveFilePath

		BaseName=S_FileName

		NVAR DataType2ch, Show2chFlag

		//if((DataType2ch ==0 || Show2chFlag==0) && SaveBCRFlag !=1)
		DoWIndow/K Image1ch
		//endif
		//	if((DataType2ch !=0 && Show2chFlag==1)&& SaveBCRFlag !=1)
		//	DoWIndow/K Image1ch
		//		DoWIndow/K Image2ch
		//	endif
		//

		//   SetBackground SaveImages(

		for(index=0;index<FrameNum;index+=1)
			ImageIndex=index


			if(index==0)
				DoWIndow ProgressBar
				if(V_flag==0)
					pnlProgress()
				endif
			endif

			if(index==FrameNum-1)
				DoWIndow/K/Z ProgressBar
			endif

			percentFinished=index*100/FrameNUm
			DoUpDate

			ret=tu_DisplayIndexedImage()
			if(ret==1)
				DoAlert 1, "Error: td_DisplayIndexedImage"
				return 0
			endif


			if(CheckSwapChFlag==1)

				Duplicate/O DisplayImage TempSwapImage

				Duplicate/O DisplayImage2ch DisplayImage

				Duplicate/O TempSwapImage DisplayImage2ch

				KIllWaves TempSwapImage

			endif

			//	if(DataType2ch ==0 || Show2chFlag==0)
			ShowImage(0)

			//	endif
			//	if(DataType2ch !=0 && Show2chFlag==1)
			//		ShowImage(0)
			//		ShowImage2ch( 0)
			//	endif

			NVAR TimeFlag=root:ViewVariables:TimeFlag
			if(TimeFlag==1)
				AddTimeCap( index)
			endif

			NVAR ScaleFlag=root:ViewVariables:ScaleFlag
			NVAR FileNameFlag=root:ViewVariables:FileNameFlag

			if(ScaleFlag==1)
				AddScaleCapFirst()
			endif

			if(FileNameFlag==1)
				AddFileNameCapFirst()
			endif

			if(ImageIndex<10)
				presuffix="0000"
			endif
			if(10<=ImageIndex && ImageIndex<99 )
				presuffix="000"
			endif
			if(100<=ImageIndex && ImageIndex<999 )
				presuffix="00"
			endif
			if(1000<=ImageIndex && ImageIndex<10000 )
				presuffix="0"
			endif

			SaveFileName=BaseName+presuffix+num2str(ImageIndex)

			if(SaveBMPFlag==1)

				SaveAsBMP(SaveFileName)
			endif

			if(SaveJPEGFlag==1)
				SaveAsJPEG(SaveFileName)

			endif

			if(SaveTIFFFlag==1)
				SaveAsTIFF(SaveFileName)
			endif

			if(SaveBCRFlag==1)



				//if(DataType2ch ==0 || Show2chFlag==0)
				SaveFileName +=".bcrf"
				ret=tu_SaveAsBCR(DisplayImage)
				if(ret==1)
					DoAlert 1, "Error: tu_SaveAsBCR: Don't use Japanese word as the data folder"
					return 0
				endif
				//endif
				//			if(DataType2ch !=0 && Show2chFlag==1)
				//
				//					SaveFileName_Base=SaveFileName
				//
				//
				//					SaveFileName =SaveFileName_Base+"_1ch.bcrf"
				//					ret=tu_SaveAsBCR(DisplayImage)
				//					if(ret==1)
				//						DoAlert 1, "Error: td_SaveAsBCR"
				//						return 0
				//					endif
				//					SaveFileName =SaveFileName_Base+"_2ch.bcrf"
				//					ret=tu_SaveAsBCR(DisplayImage2ch)
				//					if(ret==1)
				//						DoAlert 1, "Error: td_SaveAsBCR"
				//						return 0
				//					endif
				//				endif
				//
				//
			endif

		Endfor

		SaveFlag=0
		DoWIndow/K Image1ch
		if(DataType2ch !=0 && Show2chFlag==1)
			DoWIndow/K Image1ch
			DoWIndow/K Image2ch
		endif

		ImageIndex=RecordedIndex

		ret=tu_DisplayIndexedImage()
		if(ret==1)
			DoAlert 1, "Error:td_DisplayIndexedImage"
			return 0
		endif


		if(CheckSwapChFlag==1)

			Duplicate/O DisplayImage TempSwapImage

			Duplicate/O DisplayImage2ch DisplayImage

			Duplicate/O TempSwapImage DisplayImage2ch

			KIllWaves TempSwapImage

		endif

		//if(DataType2ch ==0 || Show2chFlag==0)
		ShowImage(0)
		//endif
		//if(DataType2ch !=0 && Show2chFlag==1)
		//	ShowImage(0)
		//	ShowImage2ch( 0)
		//endif

		DoWIndow/K/Z ProgressBar
	Endif

	///
	if(SaveModeFlag==2 &&   (SaveBMPFlag==1 || SaveJPEGFlag==1 || SaveTIFFFlag==1 || SaveBCRFlag==1))  // Limited Frames

		BaseName=FileNameOnly(FileName)+"_"

		if(SaveFloderFlag==0)
			Open/D/P=ViewPath/T="????"/M="Select Folder and Type BaseName" refnum as BaseName
		else
			Open/D/P=PICPath/T="????"/M="Select Folder and Type BaseName" refnum as BaseName
		endif

		strswitch(S_FileName)
			case "":
				return 0
		endswitch


		SaveFilePath=RemoveFromList(StringFromList(ItemsInList(S_FileName, ":")-1, S_FileName, ":"), S_FileName, ":")

		NewPath/O/Q SaveImagePath, SaveFilePath

		BaseName=S_FileName

		NVAR DataType2ch, Show2chFlag

		//if( (DataType2ch ==0 || Show2chFlag==0) && SaveBCRFlag !=1)
		DoWIndow/K Image1ch
		//endif
		//if((DataType2ch !=0 && Show2chFlag==1) && SaveBCRFlag !=1)
		//	DoWIndow/K Image1ch
		//	DoWIndow/K Image2ch
		//endif

		NVAR FirstFrame
		NVAR LastFrame

		Wave DisplayImage

		for(index=FirstFrame;index<=LastFrame;index+=1)
			ImageIndex=index

			if(index==FirstFrame)
				DoWIndow ProgressBar
				if(V_flag==0)
					pnlProgress()
				endif
			endif

			if(index==LastFrame-1)
				DoWIndow/K/Z ProgressBar
			endif

			percentFinished=index*100/(LastFrame-FirstFrame)
			DoUpDate

			ret=tu_DisplayIndexedImage()
			if(ret==1)
				DoAlert 1, "Error:td_DisplayIndexedImage"
				return 0
			endif


			if(CheckSwapChFlag==1)

				Duplicate/O DisplayImage TempSwapImage

				Duplicate/O DisplayImage2ch DisplayImage

				Duplicate/O TempSwapImage DisplayImage2ch

				KIllWaves TempSwapImage

			endif

			//if(DataType2ch ==0 || Show2chFlag==0)
			ShowImage(0)
			//endif
			//if(DataType2ch !=0 && Show2chFlag==1)
			//	ShowImage(0)
			//	ShowImage2ch( 0)
			//endif

			NVAR TimeFlag=root:ViewVariables:TimeFlag
			if(TimeFlag==1)
				AddTimeCap( index)
			endif

			NVAR ScaleFlag=root:ViewVariables:ScaleFlag
			NVAR FileNameFlag=root:ViewVariables:FileNameFlag

			if(ScaleFlag==1)
				AddScaleCapFirst()
			endif

			if(FileNameFlag==1)
				AddFileNameCapFirst()
			endif



			if(ImageIndex<10)
				presuffix="0000"
			endif
			if(10<=ImageIndex && ImageIndex<=99 )
				presuffix="000"
			endif
			if(100<=ImageIndex && ImageIndex<=999 )
				presuffix="00"
			endif
			if(1000<=ImageIndex && ImageIndex<=10000 )
				presuffix="0"
			endif

			SaveFileName=BaseName+presuffix+num2str(ImageIndex)

			if(SaveBMPFlag==1)

				SaveAsBMP(SaveFileName)
			endif

			if(SaveJPEGFlag==1)
				SaveAsJPEG(SaveFileName)

			endif

			if(SaveTIFFFlag==1)
				SaveAsTIFF(SaveFileName)
			endif

			if(SaveBCRFlag==1)

				//if(DataType2ch ==0 || Show2chFlag==0)
				SaveFileName +=".bcrf"
				ret=tu_SaveAsBCR(DisplayImage)
				if(ret==1)
					DoAlert 1, "Error:tu_SaveAsBCR: Don't use Japanese words as the data folder!"
					return 0
				endif
				//endif
				//				if(DataType2ch !=0 && Show2chFlag==1)
				//
				//					SaveFileName_Base=SaveFileName
				//
				//
				//					SaveFileName =SaveFileName_Base+"_1ch.bcrf"
				//					ret=tu_SaveAsBCR(DisplayImage)
				//					if(ret==1)
				//						DoAlert 1, "Error:td_SaveAsBCR"
				//						return 0
				//					endif
				//					SaveFileName =SaveFileName_Base+"_2ch.bcrf"
				//					ret=tu_SaveAsBCR(DisplayImage2ch)
				//					if(ret==1)
				//						DoAlert 1, "Error:td_SaveAsBCR"
				//						return 0
				//					endif
				//				endif


			endif

		Endfor

		SaveFlag=0
		DoWIndow/K Image1ch
		//	if(DataType2ch !=0 && Show2chFlag==1)
		//		DoWIndow/K Image1ch
		//		DoWIndow/K Image2ch
		//	endif

		ImageIndex=RecordedIndex

		ret=tu_DisplayIndexedImage()
		if(ret==1)
			DoAlert 1, "Error:td_DisplayIndexedImage"
			return 0
		endif


		if(CheckSwapChFlag==1)

			Duplicate/O DisplayImage TempSwapImage

			Duplicate/O DisplayImage2ch DisplayImage

			Duplicate/O TempSwapImage DisplayImage2ch

			KIllWaves TempSwapImage

		endif

		//	if(DataType2ch ==0 || Show2chFlag==0)
		ShowImage(0)
		//		endif
		//		if(DataType2ch !=0 && Show2chFlag==1)
		//			ShowImage(0)
		//			ShowImage2ch( 0)
		//		endif

		NVAR TimeFlag=root:ViewVariables:TimeFlag
		if(TimeFlag==1)
			AddTimeCap( index)
		endif

		NVAR ScaleFlag=root:ViewVariables:ScaleFlag
		NVAR FileNameFlag=root:ViewVariables:FileNameFlag

		if(ScaleFlag==1)
			AddScaleCapFirst()
		endif

		if(FileNameFlag==1)
			AddFileNameCapFirst()
		endif


		DoWIndow/K/Z ProgressBar

	Endif

	////

	if(SaveASDFlag==1)
		SaveAsASD(SaveFloderFlag)
	endif





	SetDataFolder SavedDataFolder
End

Function SaveAsBMP(SaveFileName)
	string  SaveFileName

	NVAR SaveImageRes=root:ViewVariables:SaveImageRes
	SavePICT/O/P=SaveImagePath/E=-4/RES=(SaveImageRes)/N=Image1ch as SaveFileName+".bmp"

	//SavePICT/E=-4/RES=72/W=(0,0,46,34)/P=SaveImagePath/N=Image1ch as SaveFileName+".bmp"


	//NVAR DataType2ch=root:ViewVariables:DataType2ch
	//NVAR Show2chFlag=root:ViewVariables:Show2chFlag

	//if(DataType2ch !=0 && Show2chFlag==1)

	//	SavePICT/O/P=SaveImagePath/E=-4/RES=(SaveImageRes)/N=Image2ch as SaveFileName+"_2ch"+".bmp"

	//Endif


End

Function SaveAsJPEG(SaveFileName)
	string  SaveFileName

	Wave DisplayImage

	NVAR SaveImageRes=root:ViewVariables:SaveImageRes
	SavePICT/O/P=SaveImagePath/E=-6/RES=(SaveImageRes)/N=Image1ch as SaveFileName+".jpg"

	//ImageSave/D=8/T="JPEG"/P=SaveImagePath/Q=1.00 DisplayImage as SaveFileName+".jpg"

	//NVAR DataType2ch=root:ViewVariables:DataType2ch
	//NVAR Show2chFlag=root:ViewVariables:Show2chFlag

	//if(DataType2ch !=0 && Show2chFlag==1)
	//	SavePICT/O/P=SaveImagePath/E=-6/RES=(SaveImageRes)/N=Image2ch as SaveFileName+"_2ch"+".jpg"


	//Endif

End

Function SaveAsTiff(SaveFileName)
	string  SaveFileName

	NVAR SaveImageRes=root:ViewVariables:SaveImageRes

	SavePICT/O/P=SaveImagePath/E=-7/RES=(SaveImageRes)/N=Image1ch as SaveFileName+".tif"

	//	NVAR DataType2ch=root:ViewVariables:DataType2ch
	//	NVAR Show2chFlag=root:ViewVariables:Show2chFlag
	//
	//	if(DataType2ch !=0 && Show2chFlag==1)
	//		SavePICT/O/P=SaveImagePath/E=-7/RES=(SaveImageRes)/N=Image2ch as SaveFileName+"_2ch"+".tif"
	//	Endif

End

Function SaveAsBCR(SaveFileName)
	string  SaveFileName
	variable refnum
	String BCRText
	variable XNum, YNum
	variable data
	variable filesize

	NVAR XPixel=root:ViewVariables:XPixel
	NVAR YPixel=root:ViewVariables:YPixel
	NVAR XScanSize=root:ViewVariables:XScanSize
	NVAR YScanSize=root:ViewVariables:YScanSize
	NVAR FrameTime=root:ViewVariables:FrameTime
	NVAR MiniData= root:ViewVariables:MiniData

	Wave DisplayImage= root:ViewVariables:DisplayImage

	WaveStats/Q/Z DisplayImage
	//	MaxData=V_Max
	MiniData=V_Min

	filesize=0

	//
	//   fileformat = bcrstm
	//xpixels = 256
	//ypixels = 256
	//xlength = 88000.0
	//ylength = 88000.0
	//xunit = nm
	//yunit = nm
	//zunit = nm
	//current = 10.0
	//bias= 0.1
	//starttime = 10 18 93 16:15:55:99
	//scanspeed = 10.1
	//intelmode = 1
	//bit2nm = 0.0592512
	//xoffset = 0.0
	//yoffset = 0.0
	//voidpixels = 0
	//

	variable i
	variable byteVal

	Open refnum as SaveFileName+".bcrf"

	BCRText="fileformat = bcrf_unicode\n"

	for(i=0;i<strlen(BCRText);i+=1)
		byteVal=char2num(BCRText[i])
		FBinWrite/f=1 refnum,byteVal
		filesize +=1
		byteVal=0
		FBinWrite/f=1 refnum,byteVal
		filesize +=1
	Endfor
	// byteVal=char2num("\n")
	//	 FBinWrite/f=1 refnum,byteVal
	//	 filesize +=1

	BCRText="%Created by Falcon\n%"

	for(i=0;i<strlen(BCRText);i+=1)
		byteVal=char2num(BCRText[i])
		FBinWrite/f=1 refnum,byteVal
		filesize +=1
		byteVal=0
		FBinWrite/f=1 refnum,byteVal
		filesize +=1
	Endfor

	BCRText=" Original file "+SaveFileName+"\n"
	for(i=0;i<strlen(BCRText);i+=1)
		byteVal=char2num(BCRText[i])
		FBinWrite/f=1 refnum,byteVal
		filesize +=1
		byteVal=0
		FBinWrite/f=1 refnum,byteVal
		filesize +=1
	Endfor

	BCRText="headersize = 2048\n"
	for(i=0;i<strlen(BCRText);i+=1)
		byteVal=char2num(BCRText[i])
		FBinWrite/f=1 refnum,byteVal
		filesize +=1
		byteVal=0
		FBinWrite/f=1 refnum,byteVal
		filesize +=1
	Endfor


	BCRText="xpixels = "+num2str(Xpixel)+"\n"
	for(i=0;i<strlen(BCRText);i+=1)
		byteVal=char2num(BCRText[i])
		FBinWrite/f=1 refnum,byteVal
		filesize +=1
		byteVal=0
		FBinWrite/f=1 refnum,byteVal
		filesize +=1
	Endfor

	BCRText="ypixels = "+num2str(Ypixel)+"\n"
	for(i=0;i<strlen(BCRText);i+=1)
		byteVal=char2num(BCRText[i])
		FBinWrite/f=1 refnum,byteVal
		filesize +=1
		byteVal=0
		FBinWrite/f=1 refnum,byteVal
		filesize +=1
	Endfor

	BCRText="xlength = "+num2str(XScanSize)+"\n"
	for(i=0;i<strlen(BCRText);i+=1)
		byteVal=char2num(BCRText[i])
		FBinWrite/f=1 refnum,byteVal
		filesize +=1
		byteVal=0
		FBinWrite/f=1 refnum,byteVal
		filesize +=1
	Endfor

	BCRText="ylength = "+num2str(YScanSize)+"\n"
	for(i=0;i<strlen(BCRText);i+=1)
		byteVal=char2num(BCRText[i])
		FBinWrite/f=1 refnum,byteVal
		filesize +=1
		byteVal=0
		FBinWrite/f=1 refnum,byteVal
		filesize +=1
	Endfor

	variable ScanSpeed
	ScanSpeed=1/(FrameTime*1e-3/YPixel)
	BCRText="scanspeed = "+num2str(ScanSpeed)+"\n"
	for(i=0;i<strlen(BCRText);i+=1)
		byteVal=char2num(BCRText[i])
		FBinWrite/f=1 refnum,byteVal
		filesize +=1
		byteVal=0
		FBinWrite/f=1 refnum,byteVal
		filesize +=1
	Endfor


	BCRText="intelmode = 1\n"
	for(i=0;i<strlen(BCRText);i+=1)
		byteVal=char2num(BCRText[i])
		FBinWrite/f=1 refnum,byteVal
		filesize +=1
		byteVal=0
		FBinWrite/f=1 refnum,byteVal
		filesize +=1
	Endfor

	BCRText="bit2nm = 1\n"
	for(i=0;i<strlen(BCRText);i+=1)
		byteVal=char2num(BCRText[i])
		FBinWrite/f=1 refnum,byteVal
		filesize +=1
		byteVal=0
		FBinWrite/f=1 refnum,byteVal
		filesize +=1
	Endfor

	BCRText="xoffset = 0\n"
	for(i=0;i<strlen(BCRText);i+=1)
		byteVal=char2num(BCRText[i])
		FBinWrite/f=1 refnum,byteVal
		filesize +=1
		byteVal=0
		FBinWrite/f=1 refnum,byteVal
		filesize +=1
	Endfor

	BCRText="yoffset = 0\n"
	for(i=0;i<strlen(BCRText);i+=1)
		byteVal=char2num(BCRText[i])
		FBinWrite/f=1 refnum,byteVal
		filesize +=1
		byteVal=0
		FBinWrite/f=1 refnum,byteVal
		filesize +=1
	Endfor

	BCRText="voidpixels = 0\n"
	for(i=0;i<strlen(BCRText);i+=1)
		byteVal=char2num(BCRText[i])
		FBinWrite/f=1 refnum,byteVal
		filesize +=1
		byteVal=0
		FBinWrite/f=1 refnum,byteVal
		filesize +=1
	Endfor

	BCRText="zmin = 0\n" //+num2str(MiniData)
	for(i=0;i<strlen(BCRText);i+=1)
		byteVal=char2num(BCRText[i])
		FBinWrite/f=1 refnum,byteVal
		filesize +=1
		byteVal=0
		FBinWrite/f=1 refnum,byteVal
		filesize +=1
	Endfor

	BCRText="xunit = nm\n"
	for(i=0;i<strlen(BCRText);i+=1)
		byteVal=char2num(BCRText[i])
		FBinWrite/f=1 refnum,byteVal
		filesize +=1
		byteVal=0
		FBinWrite/f=1 refnum,byteVal
		filesize +=1
	Endfor

	BCRText="yunit = nm\n"
	for(i=0;i<strlen(BCRText);i+=1)
		byteVal=char2num(BCRText[i])
		FBinWrite/f=1 refnum,byteVal
		filesize +=1
		byteVal=0
		FBinWrite/f=1 refnum,byteVal
		filesize +=1
	Endfor

	BCRText="zunit = [nm]\n"
	for(i=0;i<strlen(BCRText);i+=1)
		byteVal=char2num(BCRText[i])
		FBinWrite/f=1 refnum,byteVal
		filesize +=1
		byteVal=0
		FBinWrite/f=1 refnum,byteVal
		filesize +=1
	Endfor


	//
	//variable i
	byteVal=0
	for(i=0;i<(4096-filesize);i+=1)
		FBinWrite/f=1 refnum,byteVal
	endfor

	FStatus refnum
	// FSetPos refnum, 2048



	for(Ynum=0; Ynum<YPixel; Ynum+=1)
		for(Xnum=0; Xnum<Xpixel;Xnum+=1)

			data=DisplayImage[Xnum][Ynum] //*1000
			FBinWrite/F=4 refNum, data

			FStatus refnum
			//DisplayImage[Xnum][Ynum]=5-data*10/4096*PiezoConstZ*DriverGainZ

		Endfor
	Endfor
	FStatus refnum

	Close refnum


End

Function SaveAsASD( SaveFloderFlag)
	variable SaveFloderFlag
	variable ret

	string  SaveFileName
	variable refnum
	variable index
	variable data
	variable XNum, YNum
	variable Reserved=0


	NVAR  FileType=root:ViewVariables:FileType
	NVAR  FileHeaderSize=root:ViewVariables:FileHeaderSize
	NVAR  FrameHeaderSize=root:ViewVariables:FrameHeaderSize
	NVAR  TextEncoding=root:ViewVariables:TextEncoding
	NVAR  OpeNameSize=root:ViewVariables:OpeNameSize
	NVAR CommentSize=root:ViewVariables:CommentSize
	NVAR DataType1ch=root:ViewVariables:DataType1ch
	NVAR DataType2ch=root:ViewVariables:DataType2ch
	NVAR FrameNum=root:ViewVariables:FrameNum
	NVAR ImageNum=root:ViewVariables:ImageNum
	NVAR ScanDirection=root:ViewVariables:ScanDirection
	NVAR ScanTryNum=root:ViewVariables:ScanTryNum
	NVAR XPixel=root:ViewVariables:XPixel
	NVAR YPixel=root:ViewVariables:YPixel
	NVAR XScanSize=root:ViewVariables:XScanSize
	NVAR YScanSize=root:ViewVariables:YScanSize
	NVAR AveFlag=root:ViewVariables:AveFlag
	NVAR AverageNum=root:ViewVariables:AverageNum
	NVAR Year=root:ViewVariables:Year
	NVAR Month=root:ViewVariables:Month
	NVAR Day=root:ViewVariables:Day
	NVAR Hour=root:ViewVariables:Hour
	NVAR Minute=root:ViewVariables:Minute
	NVAR Second=root:ViewVariables:Second
	NVAR XRound=root:ViewVariables:XRound
	NVAR YRound=root:ViewVariables:YRound
	NVAR FrameTime=root:ViewVariables:FrameTime
	NVAR Sensitivity=root:ViewVariables:Sensitivity
	NVAR PhaseSens=root:ViewVariables:PhaseSens
	variable Offset
	NVAR MachineNo=root:ViewVariables:MachineNo
	NVAR ADRange=root:ViewVariables:ADRange
	NVAR ADResolution=root:ViewVariables:ADResolution
	NVAR MaxScanSizeX=root:ViewVariables:MaxScanSizeX
	NVAR MaxScanSizeY=root:ViewVariables:MaxScanSizeY
	NVAR PiezoConstX=root:ViewVariables:PiezoConstX
	NVAR PiezoConstY=root:ViewVariables:PiezoConstY
	NVAR PiezoConstZ=root:ViewVariables:PiezoConstZ
	NVAR DriverGainZ=root:ViewVariables:DriverGainZ
	NVAR MaxData=root:ViewVariables:MaxData
	NVAR MiniData=root:ViewVariables:MiniData
	NVAR SaveModeFlag=root:ViewVariables:SaveModeFlag

	NVAR startframe=root:ViewVariables:FirstFrame
	NVAR endFrame=root:ViewVariables:LastFrame

	SVAR Comment=root:ViewVariables:Comment

	variable size, CommentSizeForSave, FileHeaderSizeForSave

	size=FileHeaderSize-CommentSize


	//sprintf Comment, S_Selection
	//	Comment=S_Selection
	//
	CommentSizeForSave=strlen(Comment)

	FileHeaderSizeForSave=size+Commentsize


	//Frame Header
	NVAR ImageIndex=root:ViewVariables:ImageIndex

	NVAR LaserFlag=root:ViewVariables:LaserFlag

	SVAR FileName=root:ViewVariables:FileName

	NVAR CurrentNum=root:ViewVariables:CurrentNum
	NVAR XOffset=root:ViewVariables:XOffset
	NVAR YOffset=root:ViewVariables:YOffset
	NVAR XTilt=root:ViewVariables:XTilt
	NVAR YTilt=root:ViewVariables:YTilt

	NVAR Show2chFlag=root:ViewVariables:Show2chFlag

	NVAR CheckSwapChFlag=root:ViewVariables:CheckSwapChFlag



	wave DisplayImage=root:ViewVariables:DisplayImage
	wave DisplayImage2ch=root:ViewVariables:DisplayImage2ch

	SaveFileName=FileNameOnly(FileName)+"_f"+".asd"


	if(SaveFloderFlag==0)
		Open/Z/D/P=ViewPath/T="????"/M="Select Folder" refnum as SaveFileName
	else
		Open/Z/D/P=PICPath/T="????"/M="Select Folder" refnum as SaveFileName
	endif

	//Open/Z/D/P=ViewPath/T="????"/M="Select Folder" refnum as SaveFileName
	strswitch(S_FileName)
		case "":
			return 0
	endswitch

	SaveFileName=S_FileName

	variable startindex, endindex

	if(SaveModeFlag==1)
		startindex=0
		endindex=Framenum

	elseif(SaveModeFlag==2)
		startindex=startFrame
		endindex=EndFrame
	endif

	variable TargetFramenum=FrameNum

	if(DataType2ch ==0)   	  //1ch data only
		Open refnum as SaveFileName

		FrameNum=endindex-Startindex+1
		ImageNum=FrameNum

		for(index=startindex; index<=Endindex;index+=1)

			ImageIndex=index

			ret=tu_DisplayIndexedImage()
			if(ret==1)
				DoAlert 1, "Error:td_DisplayIndexedImage"
				return 0
			endif


			//
			//			Xpixel=135-59+1
			//			YPixel=158-81+1
			//
			//			Make/O/N=(Xpixel, YPixel)/O DisplayImageE
			//			variable x,y
			//			for(y=0;y<Ypixel;y+=1)
			//			for(x=0;x<xpixel;x+=1)
			//
			//			DisplayImageE[x][y]=DisplayImage[59+x][81+y]
			//
			//			endfor
			//
			//
			//			endfor
			//
			//
			//			XScanSize=XPixel*30/200
			//			YScanSize=YPixel*30/200
			//
			//			Duplicate/O DisplayImageE DisplayImage
			//			DoUpDate

			ShowImage(0)




			if(index==startindex)
				FBinWrite/F=3 refnum, FileType
				FBinWrite/F=3 refnum, FileHeaderSizeForSave
				FBinWrite/F=3 refnum, FrameHeaderSize
				FBinWrite/F=3 refnum, TextEncoding
				FBinWrite/F=3 refnum, OpeNameSize
				FBinWrite/F=3 refnum, CommentSizeForSave
				FBinWrite/F=3 refnum, DataType1ch
				FBinWrite/F=3 refnum, DataType2ch
				FBinWrite/F=3 refnum, FrameNum
				FBinWrite/F=3 refnum, ImageNum
				FBinWrite/F=3 refnum, ScanDirection
				FBinWrite/F=3 refnum, ScanTryNum
				FBinWrite/F=3 refnum, XPixel
				FBinWrite/F=3 refnum, YPixel
				FBinWrite/F=3 refnum, XScanSize
				FBinWrite/F=3 refnum, YScanSize
				FBinWrite/F=1 refnum,AveFlag
				FBinWrite/F=3 refnum,AverageNum
				FBinWrite/F=3 refnum,Year
				FBinWrite/F=3 refnum,Month
				FBinWrite/F=3 refnum,Day
				FBinWrite/F=3 refnum,Hour
				FBinWrite/F=3 refnum,Minute
				FBinWrite/F=3 refnum,Second
				FBinWrite/F=3 refnum,XRound
				FBinWrite/F=3 refnum,YRound
				FBinWrite/F=4 refnum,FrameTime
				FBinWrite/F=4 refnum,Sensitivity
				FBinWrite/F=4 refnum,PhaseSens
				FBinWrite/F=3 refnum,Offset
				FBinWrite/F=3 refnum,Offset
				FBinWrite/F=3 refnum,Offset
				FBinWrite/F=3 refnum,Offset

				FBinWrite/F=3 refnum,MachineNo
				FBinWrite/F=3 refnum,ADRange
				FBinWrite/F=3 refnum,ADResolution
				FBinWrite/F=4 refnum,MaxScanSizeX
				FBinWrite/F=4 refnum,MaxScanSizeY
				FBinWrite/F=4 refnum,PiezoConstX
				FBinWrite/F=4 refnum,PiezoConstY
				FBinWrite/F=4 refnum,PiezoConstZ
				FBinWrite/F=4 refnum,DriverGainZ

				FBinWrite refnum,OpeName

				FBinWrite refnum,Comment

			endif //index���[���̂Ƃ������t�@�C���w�b�_�̏�������
			//Frame



			WaveStats/Q/Z DisplayImage
			MaxData=V_Max
			MiniData=V_Min


			FSetPos refnum, FileHeaderSizeForSave+(FrameHeaderSize+2*Xpixel*YPixel)*(index-startindex)
			CurrentNum=index
			FBinWrite/F=3/U refNum, CurrentNum
			FBinWrite/F=2/U refNum, MaxData
			FBinWrite/F=2/U refNum, MiniData
			FBinWrite/F=2 refNum, XOffset
			FBinWrite/F=2 refNum, YOffset
			FBinWrite/F=4 refNum,  XTilt
			FBinWrite/F=4 refNum, YTilt
			FBinWrite/F=1 refNum, LaserFlag
			FBinWrite/F=1 refNum, Reserved
			FBinWrite/F=2 refNum, Reserved
			FBinWrite/F=3 refNum, Reserved
			FBinWrite/F=3 refNum, Reserved

			for(Ynum=0; Ynum<YPixel; Ynum+=1)
				for(Xnum=0; Xnum<Xpixel;Xnum+=1)

					data=(5.0-DisplayImage[Xnum][Ynum]/PiezoConstZ/DriverGainZ)*4096.0/10.0

					//data= DisplayImage[Xnum][Ynum]
					//data=DisplayImage[Xnum][Ynum]*1e+9
					FBinWrite/F=2 refNum, data
					//DisplayImage[Xnum][Ynum]=5-data*10/4096*PiezoConstZ*DriverGainZ

				Endfor
			Endfor


		Endfor


		Close refnum
	Endif

	if(DataType2ch  !=0)
		Open refnum as SaveFileName

		if(SHow2chFlag==0)
			Show2chFlag=1
		endif

		//File Header
		FBinWrite/F=3 refnum, FileType
		FBinWrite/F=3 refnum, FileHeaderSizeForSave
		FBinWrite/F=3 refnum, FrameHeaderSize
		FBinWrite/F=3 refnum, TextEncoding
		FBinWrite/F=3 refnum, OpeNameSize
		FBinWrite/F=3 refnum, CommentSizeForSave
		FBinWrite/F=3 refnum, DataType1ch
		FBinWrite/F=3 refnum, DataType2ch
		FBinWrite/F=3 refnum, FrameNum
		FBinWrite/F=3 refnum, ImageNum
		FBinWrite/F=3 refnum, ScanDirection
		FBinWrite/F=3 refnum, ScanTryNum
		FBinWrite/F=3 refnum, XPixel
		FBinWrite/F=3 refnum, YPixel
		FBinWrite/F=3 refnum, XScanSize
		FBinWrite/F=3 refnum, YScanSize
		FBinWrite/F=1 refnum,AveFlag
		FBinWrite/F=3 refnum,AverageNum
		FBinWrite/F=3 refnum,Year
		FBinWrite/F=3 refnum,Month
		FBinWrite/F=3 refnum,Day
		FBinWrite/F=3 refnum,Hour
		FBinWrite/F=3 refnum,Minute
		FBinWrite/F=3 refnum,Second
		FBinWrite/F=3 refnum,XRound
		FBinWrite/F=3 refnum,YRound
		FBinWrite/F=4 refnum,FrameTime
		FBinWrite/F=4 refnum,Sensitivity
		FBinWrite/F=4 refnum,PhaseSens
		FBinWrite/F=3 refnum,Offset
		FBinWrite/F=3 refnum,Offset
		FBinWrite/F=3 refnum,Offset
		FBinWrite/F=3 refnum,Offset

		FBinWrite/F=3 refnum,MachineNo
		FBinWrite/F=3 refnum,ADRange
		FBinWrite/F=3 refnum,ADResolution
		FBinWrite/F=4 refnum,MaxScanSizeX
		FBinWrite/F=4 refnum,MaxScanSizeY
		FBinWrite/F=4 refnum,PiezoConstX
		FBinWrite/F=4 refnum,PiezoConstY
		FBinWrite/F=4 refnum,PiezoConstZ
		FBinWrite/F=4 refnum,DriverGainZ

		FBinWrite refnum,OpeName

		FBinWrite refnum,Comment

		//Fileheader 1ch
		for(index=0;index<ImageNum;index+=1)

			ImageIndex=index


			WaveStats/Q/Z DisplayImage
			MaxData=V_Max
			MiniData=V_Min


			FSetPos refnum, FileHeaderSizeForSave+(FrameHeaderSize+2*Xpixel*YPixel)*ImageIndex
			CurrentNum=index
			FBinWrite/F=3/U refNum, CurrentNum
			FBinWrite/F=2/U refNum, MaxData
			FBinWrite/F=2/U refNum, MiniData
			FBinWrite/F=2 refNum, XOffset
			FBinWrite/F=2 refNum, YOffset
			FBinWrite/F=4 refNum,  XTilt
			FBinWrite/F=4 refNum, YTilt
			FBinWrite/F=1 refNum, LaserFlag
			FBinWrite/F=1 refNum, Reserved
			FBinWrite/F=2 refNum, Reserved
			FBinWrite/F=3 refNum, Reserved
			FBinWrite/F=3 refNum, Reserved

			for(Ynum=0; Ynum<YPixel; Ynum+=1)
				for(Xnum=0; Xnum<Xpixel;Xnum+=1)

					data=4096*(5-DisplayImage[Xnum][Ynum])/PiezoConstZ/DriverGainZ/10.0
					FBinWrite/F=2 refNum, data
					//DisplayImage[Xnum][Ynum]=5-data*10/4096*PiezoConstZ*DriverGainZ

				Endfor
			Endfor

		endfor

		for(index=0;index<ImageNum;index+=1)
			ImageIndex=index


			FSetPos refnum, FileHeaderSize+(FrameHeaderSize+2*Xpixel*YPixel)*(FrameNum+ImageIndex)

			WaveStats/Q/Z DisplayImage2ch
			MaxData=V_Max
			MiniData=V_Min

			FBinWrite/F=3/U refNum, CurrentNum
			FBinWrite/F=2/U refNum, MaxData
			FBinWrite/F=2/U refNum, MiniData
			FBinWrite/F=2 refNum, XOffset
			FBinWrite/F=2 refNum, YOffset
			FBinWrite/F=4 refNum,  XTilt
			FBinWrite/F=4 refNum, YTilt
			FBinWrite/F=1 refNum, LaserFlag
			FBinWrite/F=1 refNum, Reserved
			FBinWrite/F=2 refNum, Reserved
			FBinWrite/F=3 refNum, Reserved
			FBinWrite/F=3 refNum, Reserved

			for(Ynum=0; Ynum<YPixel; Ynum+=1)
				for(Xnum=0; Xnum<Xpixel;Xnum+=1)

					data=4096*(DisplayImage2ch[Xnum][Ynum]-5)/10.0
					FBinWrite/F=2 refNum, data

				Endfor
			Endfor
		endfor

		Close refnum
	Endif  //1ch && 2ch

	imageindex=StartFrame

		ret=tu_DisplayIndexedImage()
			if(ret==1)
				DoAlert 1, "Error:td_DisplayIndexedImage"
				return 0
			endif

			SHowImage(0)

			FrameNum=TargetFramenum
			ImageNum=TargetFramenum

End

Function PopParametersProc(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr

	NVAR DataType2ch=root:ViewVariables:DataType2ch

	if(popNum==1)

		DataType2ch=69
	else
		DataType2ch=1349
	Endif

End



Function ButtonConvertToASD(ctrlName) : ButtonControl
	String ctrlName

	string  SaveFileName
	variable refnum
	variable index
	variable data
	variable XNum, YNum
	variable Reserved=0

	variable i

	NVAR FirstFileforASD=root:ViewVariables:FirstFileforASD
	NVAR LastFileforASD=root:ViewVariables:LastFileforASD

	NVAR ImageFileIndex=root:ViewVariables:ImageFileIndex


	NVAR  FileType=root:ViewVariables:FileType
	NVAR  FileHeaderSize=root:ViewVariables:FileHeaderSize
	NVAR  FrameHeaderSize=root:ViewVariables:FrameHeaderSize
	NVAR  TextEncoding=root:ViewVariables:TextEncoding
	NVAR  OpeNameSize=root:ViewVariables:OpeNameSize
	NVAR CommentSize=root:ViewVariables:CommentSize
	NVAR DataType1ch=root:ViewVariables:DataType1ch
	NVAR DataType2ch=root:ViewVariables:DataType2ch
	NVAR FrameNum=root:ViewVariables:FrameNum
	NVAR ImageNum=root:ViewVariables:ImageNum
	NVAR ScanDirection=root:ViewVariables:ScanDirection
	NVAR ScanTryNum=root:ViewVariables:ScanTryNum
	NVAR XPixel=root:ViewVariables:XPixel
	NVAR YPixel=root:ViewVariables:YPixel
	NVAR XScanSize=root:ViewVariables:XScanSize
	NVAR YScanSize=root:ViewVariables:YScanSize
	NVAR AveFlag=root:ViewVariables:AveFlag
	NVAR AverageNum=root:ViewVariables:AverageNum
	NVAR Year=root:ViewVariables:Year
	NVAR Month=root:ViewVariables:Month
	NVAR Day=root:ViewVariables:Day
	NVAR Hour=root:ViewVariables:Hour
	NVAR Minute=root:ViewVariables:Minute
	NVAR Second=root:ViewVariables:Second
	NVAR XRound=root:ViewVariables:XRound
	NVAR YRound=root:ViewVariables:YRound
	NVAR FrameTime=root:ViewVariables:FrameTime
	NVAR Sensitivity=root:ViewVariables:Sensitivity
	NVAR PhaseSens=root:ViewVariables:PhaseSens
	variable Offset
	NVAR MachineNo=root:ViewVariables:MachineNo
	NVAR ADRange=root:ViewVariables:ADRange
	NVAR ADResolution=root:ViewVariables:ADResolution
	NVAR MaxScanSizeX=root:ViewVariables:MaxScanSizeX
	NVAR MaxScanSizeY=root:ViewVariables:MaxScanSizeY
	NVAR PiezoConstX=root:ViewVariables:PiezoConstX
	NVAR PiezoConstY=root:ViewVariables:PiezoConstY
	NVAR PiezoConstZ=root:ViewVariables:PiezoConstZ
	NVAR DriverGainZ=root:ViewVariables:DriverGainZ
	NVAR MaxData=root:ViewVariables:MaxData
	NVAR MiniData=root:ViewVariables:MiniData

	SVAR Comment=root:ViewVariables:Comment
	SVAR OpeName=root:ViewVariables:OpeName
	variable size, CommentSizeForSave, FileHeaderSizeForSave

	//size=FileHeaderSize-CommentSize
	//	NoteBook CommentNote selection={StartOfFile, endOfFile}
	//GetSelection notebook, CommentNote, 2

	//sprintf Comment, S_Selection
	//Comment=S_Selection

	// Set File Header Parapmeters



	//   PauseUpdate; Silent 1		// building window...
	//	NewPanel /W=(666,106,1019,290)/N=Parameters

	//Button buttonOpeNameOK,pos={137,153},size={50,20},proc=ProcOpeNameOK,title="OK"
	//SetVariable setvarOpeName,pos={62,24},size={194,15},title="Operator Name"
	//SetVariable setvarOpeName,value= root:ViewVariables:OpeName

	///       if(DataType2ch !=0)
	//       PopupMenu popup2chDataType,pos={67,49},size={141,23},title="2ch Data Type"
	//PopupMenu popup2chDataType,mode=1,popvalue="Phase",value= #"\"Phase;Error\"",proc=PopParametersProc

	//         endif





	//


	//Frame Header
	NVAR ImageIndex=root:ViewVariables:ImageIndex

	NVAR LaserFlag=root:ViewVariables:LaserFlag

	SVAR FileName=root:ViewVariables:FileName

	NVAR CurrentNum=root:ViewVariables:CurrentNum
	NVAR XOffset=root:ViewVariables:XOffset
	NVAR YOffset=root:ViewVariables:YOffset
	NVAR XTilt=root:ViewVariables:XTilt
	NVAR YTilt=root:ViewVariables:YTilt

	NVAR Show2chFlag=root:ViewVariables:Show2chFlag

	wave DisplayImage=root:ViewVariables:DisplayImage
	wave DisplayImage2ch=root:ViewVariables:DisplayImage2ch



	SVAR Basename=root:ViewVariables:Basename

	BaseNAme=FileName[0, strsearch(FileName, "1ch",0)-2]

	SaveFileName=BaseName+".asd"

	Open/Z/D/P=ViewPath/T="????"/M="Select Folder" refnum as SaveFileName
	strswitch(S_FileName)
		case "":
			return 0
	endswitch

	SaveFileName=S_FileName



	if(DataType2ch ==0)   	  //1ch data only
		Open refnum as SaveFileName
		index =0
		for(i=FirstFileforASD; i<=LastFileforASD;i+=1)

			ImageFileIndex=i
			ImageFileOpen()


			FileType=1
			FileHeaderSizeForSave=165+4*strlen(Comment)+4*strlen(OpeName)

			FrameHeaderSize=32

			TextEncoding=932

			OpeNameSize=4*strlen(OpeName)

			CommentSizeForSave=4*strlen(Comment)

			DataType1ch=20564

			FrameNum=LastFileforASD-FirstFileforASD+1

			ImageNum=FrameNum

			ScanDirection=1

			ScanTryNum=1

			AveFlag=0

			AverageNum=0

			XRound=1

			YRound=1

			if(index==0)
				FBinWrite/F=3 refnum, FileType
				FBinWrite/F=3 refnum, FileHeaderSizeForSave
				FBinWrite/F=3 refnum, FrameHeaderSize
				FBinWrite/F=3 refnum, TextEncoding
				FBinWrite/F=3 refnum, OpeNameSize
				FBinWrite/F=3 refnum, CommentSizeForSave
				FBinWrite/F=3 refnum, DataType1ch
				FBinWrite/F=3 refnum, DataType2ch
				FBinWrite/F=3 refnum, FrameNum
				FBinWrite/F=3 refnum, ImageNum
				FBinWrite/F=3 refnum, ScanDirection
				FBinWrite/F=3 refnum, ScanTryNum
				FBinWrite/F=3 refnum, XPixel
				FBinWrite/F=3 refnum, YPixel
				FBinWrite/F=3 refnum, XScanSize
				FBinWrite/F=3 refnum, YScanSize
				FBinWrite/F=1 refnum,AveFlag
				FBinWrite/F=3 refnum,AverageNum
				FBinWrite/F=3 refnum,Year
				FBinWrite/F=3 refnum,Month
				FBinWrite/F=3 refnum,Day
				FBinWrite/F=3 refnum,Hour
				FBinWrite/F=3 refnum,Minute
				FBinWrite/F=3 refnum,Second
				FBinWrite/F=3 refnum,XRound
				FBinWrite/F=3 refnum,YRound
				FBinWrite/F=4 refnum,FrameTime
				FBinWrite/F=4 refnum,Sensitivity
				FBinWrite/F=4 refnum,PhaseSens
				FBinWrite/F=3 refnum,Offset
				FBinWrite/F=3 refnum,Offset
				FBinWrite/F=3 refnum,Offset
				FBinWrite/F=3 refnum,Offset

				FBinWrite/F=3 refnum,MachineNo
				FBinWrite/F=3 refnum,ADRange
				FBinWrite/F=3 refnum,ADResolution
				FBinWrite/F=4 refnum,MaxScanSizeX
				FBinWrite/F=4 refnum,MaxScanSizeY
				FBinWrite/F=4 refnum,PiezoConstX
				FBinWrite/F=4 refnum,PiezoConstY
				FBinWrite/F=4 refnum,PiezoConstZ
				FBinWrite/F=4 refnum,DriverGainZ

				FBinWrite refnum,OpeName

				FBinWrite refnum,Comment

			endif //index���[���̂Ƃ������t�@�C���w�b�_�̏�������
			//Frame



			WaveStats/Q/Z DisplayImage
			MaxData=V_Max
			MiniData=V_Min


			FSetPos refnum, FileHeaderSizeForSave+(FrameHeaderSize+2*Xpixel*YPixel)*Index
			CurrentNum=index
			FBinWrite/F=3/U refNum, CurrentNum
			FBinWrite/F=2/U refNum, MaxData
			FBinWrite/F=2/U refNum, MiniData
			FBinWrite/F=2 refNum, XOffset
			FBinWrite/F=2 refNum, YOffset
			FBinWrite/F=4 refNum,  XTilt
			FBinWrite/F=4 refNum, YTilt
			FBinWrite/F=1 refNum, LaserFlag
			FBinWrite/F=1 refNum, Reserved
			FBinWrite/F=2 refNum, Reserved
			FBinWrite/F=3 refNum, Reserved
			FBinWrite/F=3 refNum, Reserved

			for(Ynum=0; Ynum<YPixel; Ynum+=1)
				for(Xnum=0; Xnum<Xpixel;Xnum+=1)

					data=4096*(5-DisplayImage[Xnum][Ynum]*1e+9)/(PiezoConstZ*DriverGainZ*10)
					FBinWrite/F=2 refNum, data
					//DisplayImage[Xnum][Ynum]=5-data*10/4096*PiezoConstZ*DriverGainZ

				Endfor
			Endfor

			index +=1
		Endfor


		Close refnum
	Endif

	if(DataType2ch  !=0)
		Open refnum as SaveFileName

		if(SHow2chFlag==0)
			Show2chFlag=1
		endif

		//File Header

		FileType=1
		FileHeaderSizeForSave=165+4*strlen(Comment)+4*strlen(OpeName)

		FrameHeaderSize=32

		TextEncoding=932

		OpeNameSize=4*strlen(OpeName)

		CommentSizeForSave=4*strlen(Comment)

		DataType1ch=20564

		FrameNum=LastFileforASD-FirstFileforASD+1

		ImageNum=FrameNum*2

		ScanDirection=1

		ScanTryNum=1

		AveFlag=0

		AverageNum=0

		XRound=1

		YRound=1

		FBinWrite/F=3 refnum, FileType
		FBinWrite/F=3 refnum, FileHeaderSizeForSave
		FBinWrite/F=3 refnum, FrameHeaderSize
		FBinWrite/F=3 refnum, TextEncoding
		FBinWrite/F=3 refnum, OpeNameSize
		FBinWrite/F=3 refnum, CommentSizeForSave
		FBinWrite/F=3 refnum, DataType1ch
		FBinWrite/F=3 refnum, DataType2ch
		FBinWrite/F=3 refnum, FrameNum
		FBinWrite/F=3 refnum, ImageNum
		FBinWrite/F=3 refnum, ScanDirection
		FBinWrite/F=3 refnum, ScanTryNum
		FBinWrite/F=3 refnum, XPixel
		FBinWrite/F=3 refnum, YPixel
		FBinWrite/F=3 refnum, XScanSize
		FBinWrite/F=3 refnum, YScanSize
		FBinWrite/F=1 refnum,AveFlag
		FBinWrite/F=3 refnum,AverageNum
		FBinWrite/F=3 refnum,Year
		FBinWrite/F=3 refnum,Month
		FBinWrite/F=3 refnum,Day
		FBinWrite/F=3 refnum,Hour
		FBinWrite/F=3 refnum,Minute
		FBinWrite/F=3 refnum,Second
		FBinWrite/F=3 refnum,XRound
		FBinWrite/F=3 refnum,YRound
		FBinWrite/F=4 refnum,FrameTime
		FBinWrite/F=4 refnum,Sensitivity
		FBinWrite/F=4 refnum,PhaseSens
		FBinWrite/F=3 refnum,Offset
		FBinWrite/F=3 refnum,Offset
		FBinWrite/F=3 refnum,Offset
		FBinWrite/F=3 refnum,Offset

		FBinWrite/F=3 refnum,MachineNo
		FBinWrite/F=3 refnum,ADRange
		FBinWrite/F=3 refnum,ADResolution
		FBinWrite/F=4 refnum,MaxScanSizeX
		FBinWrite/F=4 refnum,MaxScanSizeY
		FBinWrite/F=4 refnum,PiezoConstX
		FBinWrite/F=4 refnum,PiezoConstY
		FBinWrite/F=4 refnum,PiezoConstZ
		FBinWrite/F=4 refnum,DriverGainZ

		FBinWrite refnum,OpeName

		FBinWrite refnum,Comment

		//Fileheader 1ch
		index=0
		for(i=FirstFileforASD;i<=LastFileforASD;i+=1)

			ImageFileIndex=i
			ImageFileOpen()


			WaveStats/Q/Z DisplayImage
			MaxData=V_Max
			MiniData=V_Min


			FSetPos refnum, FileHeaderSizeForSave+(FrameHeaderSize+2*Xpixel*YPixel)*Index
			CurrentNum=index
			FBinWrite/F=3/U refNum, CurrentNum
			FBinWrite/F=2/U refNum, MaxData
			FBinWrite/F=2/U refNum, MiniData
			FBinWrite/F=2 refNum, XOffset
			FBinWrite/F=2 refNum, YOffset
			FBinWrite/F=4 refNum,  XTilt
			FBinWrite/F=4 refNum, YTilt
			FBinWrite/F=1 refNum, LaserFlag
			FBinWrite/F=1 refNum, Reserved
			FBinWrite/F=2 refNum, Reserved
			FBinWrite/F=3 refNum, Reserved
			FBinWrite/F=3 refNum, Reserved

			for(Ynum=0; Ynum<YPixel; Ynum+=1)
				for(Xnum=0; Xnum<Xpixel;Xnum+=1)

					data=4096*(5-DisplayImage[Xnum][Ynum]*1e+9)/PiezoConstZ/DriverGainZ/10.0
					FBinWrite/F=2 refNum, data
					//DisplayImage[Xnum][Ynum]=5-data*10/4096*PiezoConstZ*DriverGainZ

				Endfor
			Endfor

			index+=1

		endfor

		index=0
		for(i=FirstFileforASD;i<=LastFileforASD;i+=1)
			ImageFileIndex=i
			ImageFileOpen()


			FSetPos refnum, FileHeaderSize+(FrameHeaderSize+2*Xpixel*YPixel)*(FrameNum+Index)

			WaveStats/Q/Z DisplayImage2ch
			MaxData=V_Max
			MiniData=V_Min

			FBinWrite/F=3/U refNum, CurrentNum
			FBinWrite/F=2/U refNum, MaxData
			FBinWrite/F=2/U refNum, MiniData
			FBinWrite/F=2 refNum, XOffset
			FBinWrite/F=2 refNum, YOffset
			FBinWrite/F=4 refNum,  XTilt
			FBinWrite/F=4 refNum, YTilt
			FBinWrite/F=1 refNum, LaserFlag
			FBinWrite/F=1 refNum, Reserved
			FBinWrite/F=2 refNum, Reserved
			FBinWrite/F=3 refNum, Reserved
			FBinWrite/F=3 refNum, Reserved

			for(Ynum=0; Ynum<YPixel; Ynum+=1)
				for(Xnum=0; Xnum<Xpixel;Xnum+=1)

					data=4096*(DisplayImage2ch[Xnum][Ynum]-5)/10.0
					FBinWrite/F=2 refNum, data

				Endfor
			Endfor
			index+=1
		endfor

		Close refnum
	Endif  //1ch && 2ch


End

Function ButtonResetConvertFile(ctrlName) : ButtonControl
	String ctrlName

	NVAR FirstFileforASD=root:ViewVariables:FirstFileforASD
	NVAR LastFileforASD=root:ViewVariables:LastFileforASD

	Wave DisplayImage=root:ViewVariables:DisplayImage

	FirstFileforASD=-1
	LastFileforASD=-1


	ControlInfo FirstFileName
	if(V_Flag !=0)
		TitleBox FirstFileNameTitle, disable=1
		TitleBox FirstFileName, disable=1
	endif
	ControlInfo LastFileName
	if(V_Flag !=0)
		TitleBox  LastFileNameTitle, disable=1
		TitleBox  LastFileName, disable=1
	endif

	ControlInfo ConvertToASD
	if(V_Flag !=0)
		Button ConvertToASD, disable=1
		Button ResetASD, disable=1
	endif

End


Function SaveDataforAnalysis(i)
	variable i

	Wave DisplayImage=root:ViewVariables:DisplayImage

	if(i==0)
		NewPath/M="Save Folder"/O/Q/Z ImageSavePath
	endif

	if(i<10)
		Save/C/O/P=ImageSavePath DisplayImage as "Image_00"+num2str(i)+".ibw"
	endif
	if(i>=10 && i<100)
		Save/C/O/P=ImageSavePath DisplayImage as "Image_0"+num2str(i)+".ibw"
	endif
	if(i>=100)
		Save/C/O/P=ImageSavePath DisplayImage as "Image_"+num2str(i)+".ibw"
	endif
end


Function PopSaveModeMenuProc(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr

	NVAR SaveModeFlag=root:ViewVariables:SaveModeFlag

	SaveModeFlag=popNUm

	if(SaveModeFlag==2)

		SetVariable SetStartIndex, win=MainViewPanel, disable=0
		SetVariable SetEndIndex, win=MainViewPanel, disable=0

	else

		SetVariable SetStartIndex, win=MainViewPanel, disable=1
		SetVariable SetEndIndex, win=MainViewPanel, disable=1

	endif

End


Function PopSaveImageRes(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr

	NVAR SaveImageResNum=root:ViewVariables:SaveImageResNum
	NVAR SaveImageRes=root:ViewVariables:SaveImageRes

	SaveImageResNum=popNum

	switch(SaveImageResNum)
		case 1:
			SaveImageRes=500
			break
		case 2:
			SaveImageRes=300
			break
		case 3:
			SaveImageRes=200
			break
		case 4:
			SaveImageRes=150
			break
		case 5:
			SaveImageRes=100
			break
	endswitch

End






Function PreTabProc(ctrlName,tabNum) : TabControl
	String ctrlName
	Variable tabNum

	NVAR TabMode=root:ViewVariables:TabMode

	if(tabNum==0)
		TabMode=tabNum
		MakeViewPanel(1)
	elseif(tabNum==1)
		TabMode=tabNum
		MakeViewPanel(1)
	Endif

	return 0
End


function KillViewWinPanel(infoStr)		//kills the background task if the meter panel is closed and updates the position
	string infoStr


	if (stringmatch(infoStr,"*kill*"))
		DoWIndow/K/Z  Image1ch
		DoWIndow/K/Z  Image2ch

		if(DataFolderExists("root:ViewVariables"))
			KillDataFolder/Z  root:ViewVariables
		endif

		if(DataFolderExists("root:ImageProcessVariables"))
			KillDataFolder/Z  root:ImageProcessVariables
		endif
		//


	endif


End

function KillInitialFolderPanel(infoStr)		//kills the background task if the meter panel is closed and updates the position
	string infoStr


	if (stringmatch(infoStr,"*kill*"))

		SaveViewParameters()

	endif


End



Function SaveViewParameters()

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables

	String SaveParameters=""

	SaveParameters+="InitialFolder"


	SaveData/Q/P=FalconViewerPath/O/J=SaveParameters "ViewParams.pxp"



	SetDataFolder SavedDataFolder
End

Function pnlProgress() : Panel

	variable Width, Height, ScreenNum

	FVScreenSize(Width,Height, ScreenNum)
	PauseUpdate; Silent 1		// building window...
	NewPanel  as "Progress"
	DoWindow/C/T ProgressBar, "Progress"
	MoveWindow/W=ProgressBar 10,Height/2.2,10+170,Height/2.2+60
	SetDrawLayer UserBack
	SetDrawEnv fsize= 16
	DrawText 74,23,"Progress:"
	ValDisplay valdispProgress,pos={8,28},size={200,45},frame=4
	ValDisplay valdispProgress,limits={0,100,0},barmisc={10,1},bodyWidth= 200
	ValDisplay valdispProgress,value= #"root:ViewVariables:percentFinished"
	//Button buttonAbort,pos={73,78},size={70,30},proc=Button_Abort,title="Abort"
	//	Button buttonAbort,fSize=14
End

Function Button_Abort(ba) : ButtonControl
	STRUCT WMButtonAction &ba
	switch( ba.eventCode )
		case 2: // mouse up
			//<add code here to abort the loop or process>
			break
	endswitch
	return 0
End


Function ResetImageSize()


	SetAxis/A left
	SetAxis/A Bottom
End



Function PopScaleModeProc(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr

	NVAR ScaleMode=root:ViewVariables:ScaleMode
	NVAR ScaleModeFlag=root:ViewVariables:ScaleModeFlag
	Wave DisplayImage=root:ViewVariables:DisplayImage
	Wave ColorBar=root:ViewVariables:ColorBar

	if(ScaleMode == popNum-1)
	  return 0
	endif

	ScaleMode=popNum-1

	variable zmax, zmin
	variable i, j

	if(ScaleMode==0)

		DoWIndow/K  WMImageRangeGraph

		wave DisplayImage=root:ViewVariables:DisplayImage
		wave myColors=root:ViewVariables:myColors

		zmax=WaveMAx(DisplayImage)
		zmin=WaveMin(DisplayImage)


		ModifyImage/W=Image1ch DisplayImage, cindex=MyColors

		SetScale/I x,zmin,zmax,myColors

		PopupMenu popupRangeMode,win=MainViewPanel, disable=2


	elseif(ScaleMode==1)

		DoWIndow/K  WMImageRangeGraph
		DoWindow WMImageRangeGraph
		if(V_Flag==0)
			WMCreateImageRangeGraph_F()
		endif
		//WMImageRangeDoHist_F("Image1ch")

		ScaleModeFlag=1
		ShowImage(0)

		ScaleModeFlag=0

		PopupMenu popupRangeMode,win=MainViewPanel, disable=0



	endif

		DoWIndow ColorBarPanel
		if(v_flag==1)
		 ShowColorBar()
		endif

End

Function PopRangeModeProc(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr

	NVAR RangeMode=root:ViewVariables:RangeMode

	RangeMode=popNum-1

	Wave HistWave=root:ViewVariables:DisplayImage_WMUF:hist
	Wave DisplayImage=root:ViewVariables:DisplayImage
	Wave MyColors=root:ViewVariables:MyColors


	if(RangeMode==0)

		WaveStats/Q DIsplayImage

		DisplayImage -=V_avg

	elseif(RangeMode==1)

		WaveStats/Q DIsplayImage

		DisplayImage -=V_max

	elseif(RangeMode==2)

		WaveStats/Q DIsplayImage

		DisplayImage -=V_min


	elseif(RangeMode==3)

		WaveStats/Q HistWave

		variable MaxZ

		MaxZ=V_maxRowLoc*DimDelta(HistWave,0)+DimOffset(HistWave,0)

		DisplayImage -=MaxZ

	endif

	WMImageRangeDoHist_F("Image1ch")
	NVAR nzmax= root:Packages:WMImProcess:ImageRange:zmax
	NVAR nzmin= root:Packages:WMImProcess:ImageRange:zmin

	SetScale/I x,nzmin,nzmax,myColors
	// ModifyImage/W=Image1ch DisplayImage ctab= {nzmin,nzmax,}

	//DoWIndow/K  WMImageRangeGraph
	//DoWindow WMImageRangeGraph
	//if(V_Flag==0)
	WMCreateImageRangeGraph_F()
	//endif

	ShowImage(0)

	WMContAutoButtonProc_F("")

	//	if(ScaleMode==1)
	//
	//		DoWindow WMImageRangeGraph
	//		if(V_Flag==0)
	//			WMCreateImageRangeGraph_F()
	//		endif
	//
	//
	//	Endif
	//
	//	if(ScaleMode==0)
	//
	//		DoWIndow/K  WMImageRangeGraph
	//
	//		wave DisplayImage=root:ViewVariables:DisplayImage
	//		wave myColors=root:ViewVariables:myColors
	//
	//		variable maxVal=WaveMAx(DisplayImage)
	//		variable miniVal=WaveMin(DisplayImage)
	//
	//
	//		ModifyImage/W=Image1ch DisplayImage, cindex=MyColors
	//
	//		SetScale/I x,MiniVal,maxVal,myColors
	//
	//
	//
	//
	//	Endif

End

Function PopMovieFormatProc(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables

	NVAR MovieFormat

	MovieFormat=popNum


	SetDataFolder $SavedDataFolder

End

Function LinearTracking()

	Execute/P "INSERTINCLUDE \":Kanazawa:FalconViewer:Cellulase Analysis\""

	Execute/P "MakeCellTrackingPanel()"
End


Function PanelSetting()

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:

	Wave RemoveB=root:RemoveB
	Wave RemoveBM=root:RemoveBM
	Wave Filter=root:Filter
	Wave FreqFilterP=root:FreqFilterP
	Wave Line=root:Line
	Wave MainViewP=root:MainViewP
	Wave ForceRP=root:ForceRP
	Wave TrackP=root:TrackP
	Wave WITrackP=root:WITrackP
	Wave AveP=root:AveP
	Wave GizmoP=root:GizmoP
	Wave GizmoSettingP=root:GizmoSettingP
	Wave InitialFolderP=root:InitialFolderP
	Wave MovieFolderP=root:MovieFolderP
	Wave EditP=root:EditP
	Wave MainSaveP=root:MainSaveP
	Wave DwellP=root:DwellP
	Wave ImageRangeP=root:ImageRangeP
	Wave SimuP=root:SimuP
	Wave ImageShiftP=root:ImageShiftP
	Wave SlicerP=root:SlicerP
	Wave MagnifyP=root:MagnifyP
	Wave StatsP=root:StatsP
	Wave InterpolationP=root:InterpolationP
	Wave MovieConfigP=root:MovieConfigP

	DoWindow RemoveBGPanel
	if(v_flag==1)

		if(WaveExists(RemoveB)==0)
			Make/N=4 RemoveB
		endif

		GetWindow  RemoveBGPanel,wsize
		RemoveB[0]=v_left
		RemoveB[1]=v_top
		RemoveB[2]=v_right
		RemoveB[3]=v_bottom
	endif

	DoWindow RemoveMBGPanel
	if(v_flag==1)

		if(WaveExists(RemoveBM)==0)
			Make/N=4 RemoveBM
		endif

		GetWindow  RemoveMBGPanel,wsize
		RemoveBM[0]=v_left
		RemoveBM[1]=v_top
		RemoveBM[2]=v_right
		RemoveBM[3]=v_bottom
	endif

	DoWindow  FilterPanel
	if(v_flag==1)

		if(WaveExists(Filter)==0)
			Make/N=4 Filter
		endif


		GetWindow   FilterPanel,wsize
		Filter[0]=v_left
		Filter[1]=v_top
		Filter[2]=v_right
		Filter[3]=v_bottom
	endif

	DoWindow FFTFilterPanel
	if(v_flag==1)

		if(WaveExists(FreqFilterP)==0)
			Make/N=4 FreqFilterP
		endif

		GetWindow   FFTFilterPanel,  wsize
		FreqFilterP[0]=v_left
		FreqFilterP[1]=v_top
		FreqFilterP[2]=v_right
		FreqFilterP[3]=v_bottom
	endif


	DoWindow ImageLineProfileGraph
	if(v_flag==1)

		if(WaveExists(Line)==0)
			Make/N=4 Line
		endif

		GetWindow  ImageLineProfileGraph,wsize
		Line[0]=v_left
		Line[1]=v_top
		Line[2]=v_right
		Line[3]=v_bottom
	endif

	NVAR TabMode=root:ViewVariables:TabMode

	DoWindow MainViewPanel
	if(v_flag==1 && TabMode==0)

		if(WaveExists(MainViewP)==0)
			Make/N=4 MainViewP
		endif


		GetWindow   MainViewPanel ,wsize
		MainViewP[0]=v_left
		MainViewP[1]=v_top
		MainViewP[2]=v_right
		MainViewP[3]=v_bottom

	elseif(v_flag==1 && TabMode==1)

		if(WaveExists(MainSaveP)==0)
			Make/N=4 MainSaveP
		endif


		GetWindow   MainViewPanel ,wsize
		MainSaveP[0]=v_left
		MainSaveP[1]=v_top
		MainSaveP[2]=v_right
		MainSaveP[3]=v_bottom
	endif

	DoWindow TrackingPanel
	if(v_flag==1)


		if(WaveExists(TrackP)==0)
			Make/N=4 TrackP
		endif


		GetWindow   TrackingPanel ,wsize
		TrackP[0]=v_left
		TrackP[1]=v_top
		TrackP[2]=v_right
		TrackP[3]=v_bottom
	endif

	DoWindow WITrackingPanel
	if(v_flag==1)

		if(WaveExists(WITrackP)==0)
			Make/N=4 WITrackP
		endif


		GetWindow   WITrackingPanel ,wsize
		WITrackP[0]=v_left
		WITrackP[1]=v_top
		WITrackP[2]=v_right
		WITrackP[3]=v_bottom
	endif

	DoWindow AveragingPanel
	if(v_flag==1)

		if(WaveExists(AveP)==0)
			Make/N=4 AveP
		endif

		GetWindow   AveragingPanel ,wsize
		AveP[0]=v_left
		AveP[1]=v_top
		AveP[2]=v_right
		AveP[3]=v_bottom
	endif

	DoWindow ForceReviewPanel
	if(v_flag==1)


		if(WaveExists(ForceRP)==0)
			Make/N=4 ForceRP
		endif

		GetWindow   ForceReviewPanel ,wsize
		ForceRP[0]=v_left
		ForceRP[2]=v_right
		ForceRP[3]=v_bottom
	endif


	DoWindow GizmoSettingPanel
	if(v_flag==1)

		if(WaveExists(GizmoSettingP)==0)
			Make/N=4 GizmoSettingP
		endif


		GetWindow   GizmoSettingPanel ,wsize
		GizmoSettingP[0]=v_left
		GizmoSettingP[1]=v_top
		GizmoSettingP[2]=v_right
		GizmoSettingP[3]=v_bottom
	endif

	DoWindow InitialFolderPanel
	if(v_flag==1)

		if(WaveExists(InitialFolderP)==0)
			Make/N=4 InitialFolderP
		endif

		GetWindow  InitialFolderPanel ,wsize
		InitialFolderP[0]=v_left
		InitialFolderP[1]=v_top
		InitialFolderP[2]=v_right
		InitialFolderP[3]=v_bottom
	endif

	DoWindow MovieFolderPanel
	if(v_flag==1)

		if(WaveExists(MovieFolderP)==0)
			Make/N=4 MovieFolderP
		endif

		GetWindow MovieFolderPanel ,wsize
		MovieFolderP[0]=v_left
		MovieFolderP[1]=v_top
		MovieFolderP[2]=v_right
		MovieFolderP[3]=v_bottom
	endif

	DoWindow EditPanel
	if(v_flag==1)

		if(WaveExists(EditP)==0)
			Make/N=4 EditP
		endif

		GetWindow EditPanel ,wsize
		EditP[0]=v_left
		EditP[1]=v_top
		EditP[2]=v_right
		EditP[3]=v_bottom
	endif


	DoWindow DwellPanel
	if(v_flag==1)

		if(WaveExists(DwellP)==0)
			Make/N=4 DwellP
		endif

		GetWindow DwellPanel ,wsize
		DwellP[0]=v_left
		DwellP[1]=v_top
		DwellP[2]=v_right
		DwellP[3]=v_bottom
	endif

	DoWindow WMImageRangeGraph
	if(v_flag==1)
		if(WaveExists(ImageRangeP)==0)
			Make/N=4 ImageRangeP
		endif
		GetWindow WMImageRangeGraph ,wsize
		ImageRangeP[0]=v_left
		ImageRangeP[1]=v_top
		ImageRangeP[2]=v_right
		ImageRangeP[3]=v_bottom
	endif


	DoWindow  TipSimPanel
	if(v_flag==1)

		if(WaveExists(SimuP)==0)
			Make/N=4 SimuP
		endif

		GetWindow  TipSimPanel ,wsize
		SimuP[0]=v_left
		SimuP[1]=v_top
		SimuP[2]=v_right
		SimuP[3]=v_bottom
	endif

	DoWindow  ImageShiftPanel
	if(v_flag==1)

		if(WaveExists(ImageShiftP)==0)
			Make/N=4 ImageShiftP
		endif

		GetWindow  ImageShiftPanel ,wsize
		ImageShiftP[0]=v_left
		ImageShiftP[1]=v_top
		ImageShiftP[2]=v_right
		ImageShiftP[3]=v_bottom
	endif

	DoWindow  SlicerPanel
	if(v_flag==1)

		if(WaveExists(SlicerP)==0)
			Make/N=4 SlicerP
		endif

		GetWindow  SlicerPanel ,wsize
		SlicerP[0]=v_left
		SlicerP[1]=v_top
		SlicerP[2]=v_right
		SlicerP[3]=v_bottom
	endif

	DoWindow  MagnifyPanel
	if(v_flag==1)

		if(WaveExists(MagnifyP)==0)
			Make/N=4 MagnifyP
		endif

		GetWindow  MagnifyPanel ,wsize
		MagnifyP[0]=v_left
		MagnifyP[1]=v_top
		MagnifyP[2]=v_right
		MagnifyP[3]=v_bottom
	endif

	DoWindow  StatsPanel
	if(v_flag==1)

		if(WaveExists(StatsP)==0)
			Make/N=4 StatsP
		endif

		GetWindow  StatsPanel ,wsize
		StatsP[0]=v_left
		StatsP[1]=v_top
		StatsP[2]=v_right
		StatsP[3]=v_bottom
	endif

	DoWindow  InterpolationPanel
	if(v_flag==1)

		if(WaveExists(InterpolationP)==0)
			Make/N=4 InterpolationP
		endif

		GetWindow  InterpolationPanel ,wsize
		InterpolationP[0]=v_left
		InterpolationP[1]=v_top
		InterpolationP[2]=v_right
		InterpolationP[3]=v_bottom
	endif

	DoWindow  MovieConfigPanel
	if(v_flag==1)

		if(WaveExists(MovieConfigP)==0)
			Make/N=4 MovieConfigP
		endif

		GetWindow  MovieConfigPanel ,wsize
		MovieConfigP[0]=v_left
		MovieConfigP[1]=v_top
		MovieConfigP[2]=v_right
		MovieConfigP[3]=v_bottom
	endif

	//
	// AutoApproachPanel ,

	String SaveWaveName=""

	SaveWaveName+="MainViewP"
	SaveWaveName+=";Line"
	SaveWaveName+=";RemoveB"
	SaveWaveName+=";RemoveBM"
	SaveWaveName+=";Filter"
	SaveWaveName+=";FreqFilterP"
	SaveWaveName+=";TrackP"
	SaveWaveName+=";WITrackP"
	SaveWaveName+=";AveP"
	SaveWaveName+=";ForceRP"
	SaveWaveName+=";GizmoSettingP"
	SaveWaveName+=";InitialFolderP"
	SaveWaveName+=";MovieFolderP"
	SaveWaveName+=";EditP"
	SaveWaveName+=";MainSaveP"
	SaveWaveName+=";DwellP"
	SaveWaveName+=";ImageRangeP"
	SaveWaveName+=";SimuP"
	SaveWaveName+=";ImageShiftP"
	SaveWaveName+=";SlicerP"
	SaveWaveName+=";MagnifyP"
	SaveWaveName+=";StatsP"
	SaveWaveName+=";InterpolationP"
	SaveWaveName+=";MovieConfigP"


	SaveData/Q/P=FalconViewerPath/O/J=SaveWaveName "ViewPanelParams.pxp"

	SetDataFolder SavedDataFolder

End


Function CheckAddInfo(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked

	NVAR InfoFlag=root:ViewVariables:InfoFlag

	DoWIndow CaptionPanel
	if(InfoFlag==0 && V_Flag==1)

		DoWIndow/K CaptionPanel

		variable ScrRes = 72/ScreenResolution		//probably unneeded
		variable Width, Height, Top, ScreenNum

		DoWIndow Image1ch
		if(V_flag==1)
			DoWIndow/K Image1ch
			ShowImage(0)
		endif

		DoWIndow Image2ch
		if(V_flag==1)
			DoWIndow/K Image2ch
			ShowImage2ch(0)
		endif


		if(WinType("wm_tmpGizmoMovieWindow")!=0)
			DoWindow/k wm_tmpGizmoMovieWindow
		endif
		//FVScreenSize(Width,Height, ScreenNum)

		//	NVAR XPixel=root:ViewVariables:XPixel
		//	NVAR YPixel=root:ViewVariables:YPixel

		//	MoveWIndow/W=Image1ch 10,10,height/3,height/3*YPixel/Xpixel
		//
	elseif(InfoFlag==1 && V_Flag!=1)

		MakeCapPanel()

	endif


End


Function MakeCapPanel()

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables

	NVAR  TimeFlag
	NVAR  TimeCap_Unit
	NVAR  TimeCap_Start
	NVAR  TimeCap_Size
	NVAR  TimeCap_Color
	NVAR   TimeCap_Font
	NVAR   TimeCap_Style
	NVAR  TimeCap_Pos


	PauseUpdate; Silent 1		// building window...

	PauseUpdate; Silent 1
	NewPanel/K=2 as "Caption Panel"
	DoWindow/C/T CaptionPanel, "Caption Panel"			//name and title the panel
	MoveWindow/W=CaptionPanel 300,490,680,720
	SetWindow CaptionPanel, hook=KillCaptionPanel

	GroupBox groupTimeCap,pos={10,5},size={155,295},title="Time", fstyle=1

	TimeFlag=0
	CheckBox CheckTimeCaption, pos={26, 32}, title="Add", variable=TimeFlag , proc=CheckAddTime

	PopupMenu popupTimeCapUnit,pos={26,52},size={71,20},title="Unit"
	PopupMenu popupTimeCapUnit,mode=TimeCap_Unit,value= #"\"ms;s\"",proc=PopTimeCapUnitProc


	if(TimeCap_Unit==1)
		SetVariable setvarTimeStart,pos={25,84},size={122,24},title="Start time", value=TimeCap_Start, format="%.2fms", proc=SetTimeCapStartProc
	else
		SetVariable setvarTimeStart,pos={25,84},size={122,24},title="Start time", value=TimeCap_Start, format="%.2fs", proc=SetTimeCapStartProc
	endif



	SetVariable setvarTImeCapSize,pos={40,114},size={85,16},value=TimeCap_Size, title="Size", proc=SetTimeCapFizeProc


	PopupMenu popupTimeCapPo,pos={39,144},size={91,20},title="Position"
	PopupMenu popupTimeCapPo,mode=TimeCap_Pos,value= #"\"LT;LB;RT;RB\"",proc=PopTimeCapPositionProc




	NVAR ScaleFlag
	NVAR ScaleBar_Unit
	NVAR ScaleBar_Length
	NVAR ScaleBar_Thickness
	NVAR ScaleBar_LPosi
	NVAR ScaleBar_TPosi

	//NVAR ScaleBar_Color


	NVAR  ScaleCap_Font
	NVAR ScaleCap_LPosi
	NVAR ScaleCap_TPosi



	ScaleFlag=1
	GroupBox groupScaleBar,pos={180,5},size={155,295},title="Scale", fstyle=1

	CheckBox CheckScaleCaption, pos={195, 32}, title="Add", variable=ScaleFlag , proc=CheckAddScale

	PopupMenu popupScaleBarUnit,pos={195,62},size={71,20},title="Unit"
	PopupMenu popupScaleBarUnit,mode=ScaleBar_Unit,value= #"\"nm;um\"",proc=PopScaleBarUnitProc

	SetVariable setvarBarLength ,pos={195,94},size={70,24},title="Size", value=ScaleBar_Length, format="%d%", proc=SetScaleProc
	SetVariable setvarBarLength, limits={10,100,1}

	SetVariable setvarBarThick ,pos={195,124},size={90,24},title="Thickness", value=ScaleBar_Thickness, format="%d", proc=SetScaleProc//, proc=SetTimeCapStartProc
	SetVariable setvarBarThick, limits={1,10,1}

	SetVariable setvarBarLPosi ,pos={195,154},size={90,24},title="Left", value=ScaleBar_LPosi, format="%d%", proc=SetScaleProc//, proc=SetTimeCapStartProc
	SetVariable setvarBarLPosi, limits={1,100,1}

	SetVariable setvarBarTPosi ,pos={195,184},size={90,24},title="Top", value=ScaleBar_TPosi, format="%d%", proc=SetScaleProc//, proc=SetTimeCapStartProc
	SetVariable setvarBarTPosi, limits={1,100,1}

	SetVariable setvarBarFont ,pos={195,214},size={90,24},title="Font Size", value=ScaleCap_Font, format="%d", proc=SetScaleProc//, proc=SetTimeCapStartProc
	SetVariable setvarBarFont, limits={1,100,1}

	SetVariable setvarCaptionLPosi ,pos={195,244},size={140,24},title="Caption Left", value=ScaleCap_LPosi, format="%.1f%", proc=SetScaleProc//, proc=SetTimeCapStartProc
	SetVariable setvarCaptionLPosi, limits={0,50,1}
	SetVariable setvarCaptionTPosi ,pos={195,274},size={140,24},title="Caption Top", value=ScaleCap_TPosi, format="%.1f%", proc=SetScaleProc//, proc=SetTimeCapStartProc
	SetVariable setvarCaptionTPosi, limits={0,100,1}


	GroupBox groupTimeFontCap,pos={350,5},size={145,295},title="Font", fstyle=1


	PopupMenu popupTimeCapFont,pos={365,32},size={73,20},title="Font"
	PopupMenu popupTimeCapFont,mode=TimeCap_Font,value= #"\"Arial;Times\"",proc=PopTimeCapFontProc

	PopupMenu popupTimeCapColor,pos={365,62},size={77,20},title="Color"
	PopupMenu popupTimeCapColor,mode=TimeCap_Color,value= #"\"White;Black;Red;Grren;Blue\"",proc=PopTimeCapColorProc

	PopupMenu popupTimeCapStyle,pos={365,92},size={77,20},title="Style"
	PopupMenu popupTimeCapStyle,mode=TimeCap_Style,value= #"\"Normal;Bold;Italic;Italic Bold;UnderLine\"",proc=PopTimeCapStyleProc


	SetDataFolder SavedDataFolder

ENd

Function SetScaleProc(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName


	NVAR  ScaleFlag=root:ViewVariables:ScaleFlag
	//NVAR FileNameFlag=root:ViewVariables:FileNameFlag
	if(ScaleFlag==1)

		AddScaleCapFirst()

	endif

End



Function CheckAddScale(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked


	NVAR ScaleFlag=root:ViewVariables:ScaleFlag



	if(ScaleFlag==1)

		AddScaleCapFirst()


	else

		DoWindow Image1ch
		if(V_Flag==1)
			SetDrawLayer/W=Image1ch/K USerFront
		endif
		DoWindow Image2ch
		if(V_Flag==1)
			SetDrawLayer/W=Image2ch/K USerFront
		endif

	endif


End

Function CheckAddFileName(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked


	NVAR FileNameFlag=root:ViewVariables:FileNameFlag



	if(FileNameFlag==1)

		AddFileNameCapFirst()


	else

		DoWindow Image1ch
		if(V_Flag==1)
			TextBox/w=Image1ch/K/N=textFileName
		endif

	endif


End

Function Check3DSaveProc(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked

	NVAR Check3DSave=root:ViewVariables:Check3DSave

	String SavedDataFolder = GetDataFolder(1)

	DoWIndow GizmoView
	if(v_flag==0)

	Check3DSave =0

	 return 0

  endif

	SetDataFolder root:GizmoViewVariables

	variable/G V_left,V_top,V_right,V_bottom
	Execute "ModifyGizmo BringToFront"
	Execute "GetGizmo/N=GizmoView winPixels"



	if(Check3DSave==1)

		// Create the graph window, if necessary; otherwise modify its size
		if(WinType("wm_tmpGizmoMovieWindow")==0)
			Display/K=2/W=(V_left,V_top,V_left+(V_right-V_left)*72/screenResolution,V_top+(V_bottom-V_top)*72/screenResolution)
			DoWindow/C wm_tmpGizmoMovieWindow
		else
			MoveWindow/W=wm_tmpGizmoMovieWindow V_left,V_top,V_left+(V_right-V_left)*72/screenResolution,V_top+(V_bottom-V_top)*72/screenResolution
		endif
		//SetDataFolder oldDF
		Execute "ExportGizmo Clip"
		LoadPict/Q/O "Clipboard",wm_GizmoMoviePict
		DoWindow/F wm_tmpGizmoMovieWindow
		Setdrawlayer/k/w=wm_tmpGizmoMovieWindow userFront									// 13OCT10
		DrawPict /w=wm_tmpGizmoMovieWindow 0,0,1,1,GalleryGlobal#wm_GizmoMoviePict		// 30APR09

		NVAR TimeFlag=root:ViewVariables:TimeFlag

		if(TimeFlag==1)

			AddTimeCap3D_First()
		endif

	else

		DoWindow/K wm_tmpGizmoMovieWindow

	endif

	DoWIndow/F wm_tmpGizmoMovieWindow

	//DoAutoSizeImage(2, 0)

	SetDataFolder SavedDataFolder


End

Function CheckAddTime(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked


	NVAR TimeFlag=root:ViewVariables:TimeFlag



	if(TimeFlag==1)

		AddTimeCapFirst()

		//
		//		if(WinType("GizmoView")!=0)
		//
		//			string oldFD = GetDataFolder(1)
		//			SetDataFolder root:GizmoViewVariables
		//
		//			variable/G V_left,V_top,V_right,V_bottom
		//			Execute "ModifyGizmo BringToFront"
		//			Execute "GetGizmo/N=GizmoView winPixels"
		//			SetDataFolder oldFD
		//
		//
		//			if(WinType("wm_tmpGizmoMovieWindow")==0)
		//				Display/K=2/W=(V_left,V_top,V_left+(V_right-V_left)*72/screenResolution,V_top+(V_bottom-V_top)*72/screenResolution)
		//				DoWindow/C wm_tmpGizmoMovieWindow
		//			else
		//				MoveWindow/W=wm_tmpGizmoMovieWindow V_left,V_top,V_left+(V_right-V_left)*72/screenResolution,V_top+(V_bottom-V_top)*72/screenResolution
		//			endif
		//
		//			Execute "ExportGizmo Clip"
		//			LoadPict/Q/O "Clipboard",wm_GizmoMoviePict
		//			DoWindow/F wm_tmpGizmoMovieWindow
		//			Setdrawlayer/k/w=wm_tmpGizmoMovieWindow userFront									// 13OCT10
		//			DrawPict /w=wm_tmpGizmoMovieWindow 0,0,1,1,GalleryGlobal#wm_GizmoMoviePict		// 30APR09
		//
		//			AddTimeCapFirst3D()
		//		endif
	else

		DoWindow Image1ch
		if(V_Flag==1)
			TextBox/w=Image1ch/K/N=text1
		endif
		//DoWindow Image2ch
		//if(V_Flag==1)
		//	TextBox/w=Image2ch/K/N=text1
		//endif


		NVAR Check3DSave

		if(WinType("wm_tmpGizmoMovieWindow")!=0 && Check3DSave==1)
			TextBox/w=wm_tmpGizmoMovieWindow/K/N=text1
		endif


	endif


End

Function CheckShowRangeProc(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked


	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables

	NVAR CheckShowRange

	DoWindow Image1ch

	if(v_flag==1)

		DoWIndow/K Image1ch

	endif

	ShowImage(1)

	NVAR MovieSize
	DoAutoSizeImageFalcon(MovieSize,1)

	NVAR TimeFlag=root:ViewVariables:TimeFlag

	if(TimeFlag==1)

		AddTimeCapFirst()

	endif

	NVAR ScaleFlag=root:ViewVariables:ScaleFlag
	NVAR FileNameFlag=root:ViewVariables:FileNameFlag

	if(ScaleFlag==1)
		AddScaleCapFirst()
	endif

	if(FileNameFlag==1)
		AddFileNameCapFirst()
	endif


	SetDataFolder SavedDataFolder

End

Function PopTimeCapUnitProc(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr

	NVAR  TimeCap_Unit=root:ViewVariables:TimeCap_Unit

	TimeCap_Unit=popNum

	if(TimeCap_Unit==1)
		SetVariable setvarTimeStart,format="%.2fms"
	elseif(TimeCap_Unit==2)
		SetVariable setvarTimeStart, format="%.2fs"
	elseif(TimeCap_Unit==3)
		SetVariable setvarTimeStart, format="%.2fmin"
	endif

	AddTimeCapFirst()

	if(WinType("wm_tmpGizmoMovieWindow")!=0)
		AddTimeCapFirst3D()
	endif

End


Function PopTimeCapRoundingProc(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr

	NVAR  TimeCap_Rounding=root:ViewVariables:TimeCap_Rounding

	TimeCap_Rounding=popNum


	AddTimeCapFirst()

	if(WinType("wm_tmpGizmoMovieWindow")!=0)
		AddTimeCapFirst3D()
	endif

End

Function PopScaleBarUnitProc(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr


	NVAR ScaleBar_Unit=root:ViewVariables:ScaleBar_Unit

	ScaleBar_Unit=popNum

	NVAR  ScaleFlag=root:ViewVariables:ScaleFlag
	if(ScaleFlag==1)

		AddScaleCapFirst()

	endif


End

Function PopTimeCapColorProc(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr

	NVAR  TimeCap_Color=root:ViewVariables:TimeCap_Color
	NVAR  TimeFlag=root:ViewVariables:TimeFlag
	NVAR  ScaleFlag=root:ViewVariables:ScaleFlag
	NVAR FileNameFlag=root:ViewVariables:FileNameFlag

	TimeCap_Color=popNum

	if(TimeFlag==1)
		AddTimeCapFirst()


		if(WinType("wm_tmpGizmoMovieWindow")!=0)
			AddTimeCapFirst3D()
		endif
	endif

	if(ScaleFlag==1)
		AddScaleCapFirst()
	endif

	if(FileNameFlag==1)
		AddFileNameCapFirst()
	endif

End

Function PopTimeCapStyleProc(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr

	NVAR  TimeFlag=root:ViewVariables:TimeFlag
	NVAR  TimeCap_Style=root:ViewVariables:TimeCap_Style

	TimeCap_Style=popNum

	if(TimeFlag==1)

		AddTimeCapFirst()

		if(WinType("wm_tmpGizmoMovieWindow")!=0)
			AddTimeCapFirst3D()
		endif

	endif

	NVAR  ScaleFlag=root:ViewVariables:ScaleFlag
	NVAR FileNameFlag=root:ViewVariables:FileNameFlag

	if(ScaleFlag==1)
		AddScaleCapFirst()
	endif

	if(FileNameFlag==1)
		AddFileNameCapFirst()
	endif


End

Function PopTimeCapFontProc(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr

	NVAR  TimeFlag=root:ViewVariables:TimeFlag
	NVAR  ScaleFlag=root:ViewVariables:ScaleFlag
	NVAR FileNameFlag=root:ViewVariables:FileNameFlag

	NVAR  TimeCap_Font=root:ViewVariables:TimeCap_Font

	TimeCap_Font=popNum

	if(TimeFlag==1)
		AddTimeCapFirst()

		if(WinType("wm_tmpGizmoMovieWindow")!=0)
			AddTimeCapFirst3D()
		endif
	endif

	if(ScaleFlag==1)
		AddScaleCapFirst()
	endif

	if(FileNameFlag==1)
		AddFileNameCapFirst()
	endif


End

Function PopTimeCapPositionProc(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr


	NVAR  TimeFlag=root:ViewVariables:TimeFlag

	NVAR  TimeCap_Pos=root:ViewVariables:TimeCap_Pos

	TimeCap_Pos=popNum

	if(TimeFlag==1)
		AddTimeCapFirst()

		if(WinType("wm_tmpGizmoMovieWindow")!=0)
			AddTimeCapFirst3D()
		endif

	endif



End

Function PopInterPMethodProc(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr

	NVAR  InterPMethod=root:ViewVariables:InterPMethod
	//NVAR ScaleModeFlag=root:ViewVariables:ScaleModeFlag
	//Wave DisplayImage=root:ViewVariables:DisplayImage
	//Wave ColorBar=root:ViewVariables:ColorBar

	 InterPMethod=popNum

//	if( InterPMethod ==1)
//
//	   PopupMenu popupResamplingFunc,win=InterpolationPanel, disable =1
//	   SetVariable setvarSplineDeg, win=InterpolationPanel, disable =1
//
//	 elseif(InterPMethod ==2)
//
//	   PopupMenu popupResamplingFunc,win=InterpolationPanel, disable =1
//	   SetVariable setvarSplineDeg, win=InterpolationPanel, disable =0
//
//	elseif(InterPMethod ==3)
//
//	   PopupMenu popupResamplingFunc,win=InterpolationPanel, disable =0
//	   SetVariable setvarSplineDeg, win=InterpolationPanel, disable =1
//	endif
///

End

Function PopResampleFucProc(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr

	NVAR ResamplingFunc=root:ViewVariables:ResamplingFunc
	//NVAR ScaleModeFlag=root:ViewVariables:ScaleModeFlag
	//Wave DisplayImage=root:ViewVariables:DisplayImage
	//Wave ColorBar=root:ViewVariables:ColorBar

	ResamplingFunc=popNum

End


Function SetTimeCapFizeProc(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName

	NVAR  TimeFlag=root:ViewVariables:TimeFlag
	NVAR  TimeCap_Size=root:ViewVariables:TimeCap_Size

	TimeCap_Size=VarNum

	if(TimeFlag==1)

		AddTimeCapFirst()

		if(WinType("wm_tmpGizmoMovieWindow")!=0)
			AddTimeCapFirst3D()
		endif

	endif


End

Function SetTimeCapStartProc(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName

	NVAR  TimeFlag=root:ViewVariables:TimeFlag

	if(TimeFlag==1)
		AddTimeCapFirst()

		if(WinType("wm_tmpGizmoMovieWindow")!=0)
			AddTimeCapFirst3D()
		endif

	endif

End


Function SetFileNameProc(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName

	NVAR  FileNameFlag=root:ViewVariables:FileNameFlag


	if(FileNameFlag==1)

		AddFileNameCapFirst()

		//	if(WinType("wm_tmpGizmoMovieWindow")!=0)
		//		AddTimeCapFirst3D()
		//	endif

	endif


End

Function SetMovieFrameProc(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables

	NVAR FrameRate

	if(FrameRate <1)

	SetVariable setvarFrameRate,win=MovieConfigPanel,limits={0.1,60,0.1}

	else

	FrameRate =round(FrameRate)

	SetVariable setvarFrameRate,win=MovieConfigPanel,limits={0.1,60,1}

	endif


End


function KillCaptionPanel(infoStr)		//kills the background task if the meter panel is closed and updates the position
	string infoStr


	if (stringmatch(infoStr,"*kill*"))

		TextBox/w=Image1ch/N=text1/K

		SetDrawLayer/W=Image1ch/K USerFront
		//

	endif


End



Function AddTimeCapFirst()


	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables

	NVAR  TimeCap_Unit
	NVAR  TimeCap_Start
	NVAR  TimeCap_Size
	NVAR  TimeCap_Color
	NVAR   TimeCap_Font
	NVAR  TimeCap_Pos
	NVAR  TimeCap_Style
	NVAR  TimeCap_Rounding
	NVAR FrameTime
	NVAR FirstFrame
	NVAR ImageIndex
	NVAR MovieSize

	DoWIndow/F Image1ch
	DoAutoSizeImageFalcon( MovieSize,1)


	String TimeSecond="\f"

	if(TimeCap_Style==1)
		TimeSecond +="00"
	elseif(TimeCap_Style==2)
		TimeSecond +="01"
	elseif(TimeCap_Style==3)
		TimeSecond +="02"
	elseif(TimeCap_Style==4)
		TimeSecond +="03"
	elseif(TimeCap_Style==5)
		TimeSecond +="04"
	endif

	TimeSecond +="\Z"+num2str(TimeCap_Size)

	if(TimeCap_Font==1)
		TimeSecond +="\F'Arial'"
	elseif(TimeCap_Font==1)
		TimeSecond +="\F'Times'"
	endif
	//TimeSecond +="6 min + "



	if(TimeCap_Unit==1)

		if(TimeCap_Rounding==1)
			TimeSecond +=num2str(TimeCap_Start+FrameTime)
		elseif(TimeCap_Rounding==2)
			TimeSecond +=num2str(round(TimeCap_Start+FrameTime))
		elseif(TimeCap_Rounding==3)
			TimeSecond +=num2str(ceil(TimeCap_Start+FrameTime))
		elseif(TimeCap_Rounding==4)
			TimeSecond +=num2str(floor(TimeCap_Start+FrameTime))
		endif
		TimeSecond +="ms"

	elseif(TimeCap_Unit==2)
		if(TimeCap_Rounding==1)
			TimeSecond +=num2str(TimeCap_Start+FrameTime/1000)
		elseif(TimeCap_Rounding==2)
			TimeSecond +=num2str(round(TimeCap_Start+FrameTime/1000))
		elseif(TimeCap_Rounding==3)
			TimeSecond +=num2str(ceil(TimeCap_Start+FrameTime/1000))
		elseif(TimeCap_Rounding==4)
			TimeSecond +=num2str(floor(TimeCap_Start+FrameTime/1000))
		endif
		TimeSecond +="s"
	elseif(TimeCap_Unit==3)
		variable checktime=FrameTime/60000*100

		if(TimeCap_Rounding==1)
			TimeSecond +=num2str(TimeCap_Start+round(checktime)/100)
		elseif(TimeCap_Rounding==2)
			TimeSecond +=num2str(round(TimeCap_Start+round(checktime)/100))
		elseif(TimeCap_Rounding==3)
			TimeSecond +=num2str(ceil(TimeCap_Start+round(checktime)/100))
		elseif(TimeCap_Rounding==4)
			TimeSecond +=num2str(floor(TimeCap_Start+round(checktime)/100))
		endif

		TimeSecond +="min"
	endif

	variable r, g,b

	if(TimeCap_Color==1)
		r=65535
		g=65535
		b=65535
	elseif(TimeCap_Color==2)
		r=0
		g=0
		b=0
	elseif(TimeCap_Color==3)
		r=65535
		g=0
		b=0
	elseif(TimeCap_Color==4)
		r=0
		g=65535
		b=0
	elseif(TimeCap_Color==5)
		r=0
		g=0
		b=65535
	endif

	DoWindow Image1ch
	if(V_Flag==1)
		if(TimeCap_Pos==1)
			TextBox/w=Image1ch/C/B=1/N=text1/F=0/A=LT/G=(r,g,b)/M  TimeSecond
		elseif(TimeCap_Pos==2)
			TextBox/w=Image1ch/C/B=1/N=text1/F=0/A=LB/G=(r,g,b))/M  TimeSecond
		elseif(TimeCap_Pos==3)
			TextBox/w=Image1ch/C/B=1/N=text1/F=0/A=RT/G=(r,g,b)/M  TimeSecond
		elseif(TimeCap_Pos==4)
			TextBox/w=Image1ch/C/B=1/N=text1/F=0/A=RB/G=(r,g,b)/M  TimeSecond
		endif
	endif

	DoWindow Image2ch
	if(V_Flag==1)
		if(TimeCap_Pos==1)
			TextBox/w=Image2ch/C/B=1/N=text1/F=0/A=LT/G=(r,g,b)/M  TimeSecond
		elseif(TimeCap_Pos==2)
			TextBox/w=Image2ch/C/B=1/N=text1/F=0/A=LB/G=(r,g,b))/M  TimeSecond
		elseif(TimeCap_Pos==3)
			TextBox/w=Image2ch/C/B=1/N=text1/F=0/A=RT/G=(r,g,b)/M  TimeSecond
		elseif(TimeCap_Pos==4)
			TextBox/w=Image2ch/C/B=1/N=text1/F=0/A=RB/G=(r,g,b)/M  TimeSecond
		endif
	endif


	NVAR Check3DSave
	DoWIndow wm_tmpGizmoMovieWindow

	if(v_flag==1 && Check3DSave==1)

		AddTimeCap3D_First()


	endif



	//endif


	SetDataFolder SavedDataFolder

End

Function AddTimeCap( index)

	variable index

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables

	NVAR  TimeCap_Unit
	NVAR  TimeCap_Start
	NVAR  TimeCap_Size
	NVAR  TimeCap_Color
	NVAR   TimeCap_Font
	NVAR  TimeCap_Pos
	NVAR  TimeCap_Style
	NVAR TimeCap_Rounding
	NVAR FrameTime
	NVAR FirstFrame
	NVAR ImageIndex


	String TimeSecond="\f"

	if(TimeCap_Style==1)
		TimeSecond +="00"
	elseif(TimeCap_Style==2)
		TimeSecond +="01"
	elseif(TimeCap_Style==3)
		TimeSecond +="02"
	elseif(TimeCap_Style==4)
		TimeSecond +="03"
	elseif(TimeCap_Style==5)
		TimeSecond +="04"
	endif

	TimeSecond +="\Z"+num2str(TimeCap_Size)

	if(TimeCap_Font==1)
		TimeSecond +="\F'Arial'"
	elseif(TimeCap_Font==1)
		TimeSecond +="\F'Times'"
	endif
	//TimeSecond +="6 min + "



	if(TimeCap_Unit==1)

		if(TimeCap_Rounding==1)
			TimeSecond +=num2str(TimeCap_Start+(index-FirstFrame)*FrameTime)
		elseif(TimeCap_Rounding==2)
			TimeSecond +=num2str(round(TimeCap_Start+(index-FirstFrame)*FrameTime))
		elseif(TimeCap_Rounding==3)
			TimeSecond +=num2str(ceil(TimeCap_Start+(index-FirstFrame)*FrameTime))
		elseif(TimeCap_Rounding==4)
			TimeSecond +=num2str(floor(TimeCap_Start+(index-FirstFrame)*FrameTime))
		endif
		TimeSecond +="ms"

	elseif(TimeCap_Unit==2)
		if(TimeCap_Rounding==1)
			TimeSecond +=num2str(TimeCap_Start+(index-FirstFrame)*FrameTime/1000)
		elseif(TimeCap_Rounding==2)
			TimeSecond +=num2str(round(TimeCap_Start+(index-FirstFrame)*FrameTime/1000))
		elseif(TimeCap_Rounding==3)
			TimeSecond +=num2str(ceil(TimeCap_Start+(index-FirstFrame)*FrameTime/1000))
		elseif(TimeCap_Rounding==4)
			TimeSecond +=num2str(floor(TimeCap_Start+(index-FirstFrame)*FrameTime/1000))
		endif

		TimeSecond +="s"

	elseif(TimeCap_Unit==3)
		variable checktime=(index-FirstFrame)*FrameTime/60000*100


		if(TimeCap_Rounding==1)
			TimeSecond +=num2str(TimeCap_Start+round(checktime)/100)
		elseif(TimeCap_Rounding==2)
			TimeSecond +=num2str(round(TimeCap_Start+round(checktime)/100))
		elseif(TimeCap_Rounding==3)
			TimeSecond +=num2str(ceil(TimeCap_Start+round(checktime)/100))
		elseif(TimeCap_Rounding==4)
			TimeSecond +=num2str(floor(TimeCap_Start+round(checktime)/100))
		endif

		TimeSecond +="min"
	endif

	variable r, g,b

	if(TimeCap_Color==1)
		r=65535
		g=65535
		b=65535
	elseif(TimeCap_Color==2)
		r=0
		g=0
		b=0
	elseif(TimeCap_Color==3)
		r=65535
		g=0
		b=0
	elseif(TimeCap_Color==4)
		r=0
		g=65535
		b=0
	elseif(TimeCap_Color==5)
		r=0
		g=0
		b=65535
	endif

	DoWindow Image1ch
	if(V_Flag==1)
		if(TimeCap_Pos==1)
			TextBox/w=Image1ch/C/B=1/N=text1/F=0/A=LT/G=(r,g,b)/M  TimeSecond
		elseif(TimeCap_Pos==2)
			TextBox/w=Image1ch/C/B=1/N=text1/F=0/A=LB/G=(r,g,b))/M  TimeSecond
		elseif(TimeCap_Pos==3)
			TextBox/w=Image1ch/C/B=1/N=text1/F=0/A=RT/G=(r,g,b)/M  TimeSecond
		elseif(TimeCap_Pos==4)
			TextBox/w=Image1ch/C/B=1/N=text1/F=0/A=RB/G=(r,g,b)/M  TimeSecond
		endif
	endif

	//	DoWindow Image2ch
	//	if(V_Flag==1)
	//		if(TimeCap_Pos==1)
	//			TextBox/w=Image2ch/C/B=1/N=text1/F=0/A=LT/G=(r,g,b)/M  TimeSecond
	//		elseif(TimeCap_Pos==2)
	//			TextBox/w=Image2ch/C/B=1/N=text1/F=0/A=LB/G=(r,g,b))/M  TimeSecond
	//		elseif(TimeCap_Pos==3)
	//			TextBox/w=Image2ch/C/B=1/N=text1/F=0/A=RT/G=(r,g,b)/M  TimeSecond
	//		elseif(TimeCap_Pos==4)
	//			TextBox/w=Image2ch/C/B=1/N=text1/F=0/A=RB/G=(r,g,b)/M  TimeSecond
	//		endif
	//	endif



	//endif


	SetDataFolder SavedDataFolder

End


Function AddTempCap(index)

	variable index

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables

	NVAR  TimeCap_Unit
	NVAR  TimeCap_Start
	NVAR  TimeCap_Size
	NVAR  TimeCap_Color
	NVAR   TimeCap_Font
	NVAR  TimeCap_Pos
	NVAR  TimeCap_Style
	NVAR TimeCap_Rounding
	NVAR FrameTime
	NVAR FirstFrame
	NVAR ImageIndex


	String TimeSecond="\f"

	if(TimeCap_Style==1)
		TimeSecond +="00"
	elseif(TimeCap_Style==2)
		TimeSecond +="01"
	elseif(TimeCap_Style==3)
		TimeSecond +="02"
	elseif(TimeCap_Style==4)
		TimeSecond +="03"
	elseif(TimeCap_Style==5)
		TimeSecond +="04"
	endif

	TimeSecond +="\Z"+num2str(TimeCap_Size)

	if(TimeCap_Font==1)
		TimeSecond +="\F'Arial'"
	elseif(TimeCap_Font==1)
		TimeSecond +="\F'Times'"
	endif
	//TimeSecond +="6 min + "


    if(TimeCap_Unit==1)

		if(TimeCap_Rounding==1)
			TimeSecond +=num2str(TimeCap_Start+(index-FirstFrame)*FrameTime)
		elseif(TimeCap_Rounding==2)
			TimeSecond +=num2str(round(TimeCap_Start+(index-FirstFrame)*FrameTime))
		elseif(TimeCap_Rounding==3)
			TimeSecond +=num2str(ceil(TimeCap_Start+(index-FirstFrame)*FrameTime))
		elseif(TimeCap_Rounding==4)
			TimeSecond +=num2str(floor(TimeCap_Start+(index-FirstFrame)*FrameTime))
		endif
		TimeSecond +=" ms"

	elseif(TimeCap_Unit==2)
		if(TimeCap_Rounding==1)
			TimeSecond +=num2str(TimeCap_Start+(index-FirstFrame)*FrameTime/1000)
		elseif(TimeCap_Rounding==2)
			TimeSecond +=num2str(round(TimeCap_Start+(index-FirstFrame)*FrameTime/1000))
		elseif(TimeCap_Rounding==3)
			TimeSecond +=num2str(ceil(TimeCap_Start+(index-FirstFrame)*FrameTime/1000))
		elseif(TimeCap_Rounding==4)
			TimeSecond +=num2str(floor(TimeCap_Start+(index-FirstFrame)*FrameTime/1000))
		endif

		TimeSecond +=" s"

	elseif(TimeCap_Unit==3)
		variable checktime=(index-FirstFrame)*FrameTime/60000*100


		if(TimeCap_Rounding==1)
			TimeSecond +=num2str(TimeCap_Start+round(checktime)/100)
		elseif(TimeCap_Rounding==2)
			TimeSecond +=num2str(round(TimeCap_Start+round(checktime)/100))
		elseif(TimeCap_Rounding==3)
			TimeSecond +=num2str(ceil(TimeCap_Start+round(checktime)/100))
		elseif(TimeCap_Rounding==4)
			TimeSecond +=num2str(floor(TimeCap_Start+round(checktime)/100))
		endif

		TimeSecond +=" min"
	endif

      string strtemp

	Wave TempWave =root:TempC5

	variable temp =TempWave[index]

	sprintf strtemp , "%.1f", temp

	TimeSecond += "  (" + strtemp +" degC)"




	variable r, g,b

	if(TimeCap_Color==1)
		r=65535
		g=65535
		b=65535
	elseif(TimeCap_Color==2)
		r=0
		g=0
		b=0
	elseif(TimeCap_Color==3)
		r=65535
		g=0
		b=0
	elseif(TimeCap_Color==4)
		r=0
		g=65535
		b=0
	elseif(TimeCap_Color==5)
		r=0
		g=0
		b=65535
	endif

	DoWindow Image1ch
	if(V_Flag==1)
		if(TimeCap_Pos==1)
			TextBox/w=Image1ch/C/B=1/N=text1/F=0/A=LT/G=(r,g,b)/M  TimeSecond
		elseif(TimeCap_Pos==2)
			TextBox/w=Image1ch/C/B=1/N=text1/F=0/A=LB/G=(r,g,b))/M  TimeSecond
		elseif(TimeCap_Pos==3)
			TextBox/w=Image1ch/C/B=1/N=text1/F=0/A=RT/G=(r,g,b)/M  TimeSecond
		elseif(TimeCap_Pos==4)
			TextBox/w=Image1ch/C/B=1/N=text1/F=0/A=RB/G=(r,g,b)/M  TimeSecond
		endif
	endif

	//	DoWindow Image2ch
	//	if(V_Flag==1)
	//		if(TimeCap_Pos==1)
	//			TextBox/w=Image2ch/C/B=1/N=text1/F=0/A=LT/G=(r,g,b)/M  TimeSecond
	//		elseif(TimeCap_Pos==2)
	//			TextBox/w=Image2ch/C/B=1/N=text1/F=0/A=LB/G=(r,g,b))/M  TimeSecond
	//		elseif(TimeCap_Pos==3)
	//			TextBox/w=Image2ch/C/B=1/N=text1/F=0/A=RT/G=(r,g,b)/M  TimeSecond
	//		elseif(TimeCap_Pos==4)
	//			TextBox/w=Image2ch/C/B=1/N=text1/F=0/A=RB/G=(r,g,b)/M  TimeSecond
	//		endif
	//	endif



	//endif


	SetDataFolder SavedDataFolder

End


Function AddScaleCapFirst()

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables


	NVAR ScaleFlag
	NVAR ScaleBar_Unit
	NVAR ScaleBar_Length
	NVAR ScaleBar_Thickness
	NVAR ScaleBar_LPosi
	NVAR ScaleBar_TPosi

	//NVAR ScaleCap_Style
	NVAR ScaleCap_LPosi
	NVAR ScaleCap_TPosi
	NVAR  ScaleCap_Font




	NVAR MovieSize

	NVAR XScanSize




	DoWIndow/F Image1ch
	DoAutoSizeImageFalcon( MovieSize,1)

	NVAR  TimeCap_Color
	variable r, g,b

	if(TimeCap_Color==1)
		r=65535
		g=65535
		b=65535
	elseif(TimeCap_Color==2)
		r=0
		g=0
		b=0
	elseif(TimeCap_Color==3)
		r=65535
		g=0
		b=0
	elseif(TimeCap_Color==4)
		r=0
		g=65535
		b=0
	elseif(TimeCap_Color==5)
		r=0
		g=0
		b=65535
	endif

	if(ScaleFlag==1)

		String StrScale
		variable ValScale
		variable ScaleFactor

		NVAR TimeCap_Style

		StrScale="\f"

		if(TimeCap_Style==1)
			StrScale +="00"
		elseif(TimeCap_Style==2)
			StrScale +="01"
		elseif(TimeCap_Style==3)
			StrScale +="02"
		elseif(TimeCap_Style==4)
			StrScale +="03"
		elseif(TimeCap_Style==5)
			StrScale +="04"
		endif


		NVAR  TimeCap_Font

		if(TimeCap_Font==1)
			StrScale +="\F'Arial'"
		elseif(TimeCap_Font==2)
			StrScale +="\F'Times'"
		endif


		if(ScaleBar_Unit==1)

			ScaleFactor=1
			ValScale=round(XScanSize*ScaleBar_Length/100)
			StrScale +=num2str(ValScale)
			StrScale +=" nm"

		elseif(ScaleBar_Unit==2)

			ScaleFactor=1000
			ValScale=round(XScanSize*ScaleBar_Length/100/1000)
			StrScale +=num2str(ValScale)

			if(TimeCap_Font==1)
				StrScale +=" \F'Symbol'm\F'Arial'm"
			else
				StrScale +=" \F'Symbol'm\F'Times'm"
			endif

			//\F'Symbol'm\F'Arial'm
		endif

	endif



	DoWindow Image1ch
	if(V_Flag==1)

		SetDrawLayer/W=Image1ch/K USerFront
		SetDrawLayer/W=Image1ch USerFront

		if(ScaleFlag==1)
			SetDrawEnv/W=Image1ch linethick=ScaleBar_Thickness, xcoord=prel, ycoord=prel, linefgc=(r,g,b)
			DrawLine/W=Image1ch ScaleBar_LPosi/100, ScaleBar_TPosi/100, ScaleBar_LPosi/100+ValScale/(XScanSize/ScaleFactor),ScaleBar_TPosi/100


			SetDrawEnv/W=Image1ch fsize=ScaleCap_Font, textrgb=(r,g,b ), fstyle=1//, fname=Cap_Font

			DrawText/w=Image1ch  ScaleBar_LPosi/100+ScaleCap_LPosi/100, ScaleBar_TPosi/100+ScaleCap_TPosi/100,  StrScale //-ScaleCap_TPosi/100
		endif


	endif


	SetDataFolder SavedDataFolder


End

Function AddFileNameCapFirst()

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables


	NVAR FileNameFlag
	NVAR FileNameCap_LPosi
	NVAR FileNameCap_TPosi
	NVAR FileNameCap_Size
	SVAR FileNameCap



	NVAR MovieSize

	NVAR XScanSize




	DoWIndow/F Image1ch
	DoAutoSizeImageFalcon( MovieSize,1)

	NVAR  TimeCap_Color
	variable r, g,b

	if(TimeCap_Color==1)
		r=65535
		g=65535
		b=65535
	elseif(TimeCap_Color==2)
		r=0
		g=0
		b=0
	elseif(TimeCap_Color==3)
		r=65535
		g=0
		b=0
	elseif(TimeCap_Color==4)
		r=0
		g=65535
		b=0
	elseif(TimeCap_Color==5)
		r=0
		g=0
		b=65535
	endif

	NVAR TimeCap_Style


	String StrFileName



	NVAR TimeCap_Style

	StrFilename ="\f"

	if(TimeCap_Style==1)
		StrFileName +="00"
	elseif(TimeCap_Style==2)
		StrFileName +="01"
	elseif(TimeCap_Style==3)
		StrFileName +="02"
	elseif(TimeCap_Style==4)
		StrFileName +="03"
	elseif(TimeCap_Style==5)
		StrFileName +="04"
	endif


	NVAR  TimeCap_Font

	if(TimeCap_Font==1)
		StrFileName+="\F'Arial'"
	elseif(TimeCap_Font==2)
		StrFileName +="\F'Times'"
	endif
	StrFileName +="\Z"+num2str(FileNameCap_Size)


	StrFileName +=FileNameCap


	DoWindow Image1ch
	if(V_Flag==1)


		TextBox /C/B=1/N=textFileName/F=0/A=LT/G=(r,g,b)/M/X=(FileNameCap_LPosi)/Y= (FileNameCap_TPosi)   StrFileName

	endif

	//print ScaleCap_TPosi
	//DrawText/w=Image1ch  0.5, 0, StrScale
	//TextBox/w=Image1ch/C/B=1/N=text2/F=0/A=RB/G=(r,g,b)/M  StrScale


	SetDataFolder SavedDataFolder


End

Function AddLaserBox()

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables


	NVAR MovieSize

	NVAR XScanSize

	NVAR LaserFlag

	variable BoxLposi=10
	variable BoxTposi=10
	variable BoxLength=10


	DoWindow Image1ch
	if(V_Flag==1)

		SetDrawLayer/W=Image1ch/K USerFront
		SetDrawLayer/W=Image1ch USerFront

		//if(ScaleFlag==1)
		if(LaserFlag==1)
			SetDrawEnv/W=Image1ch linethick=1, xcoord=prel, ycoord=prel, fillfgc=(0,35552,65535), linefgc=(65535,65535,65535)

		else
			SetDrawEnv/W=Image1ch linethick=1, xcoord=prel, ycoord=prel, fillfgc=(0,0,0), linefgc=(65535,65535,65535)

		endif
		DrawRect/W=Image1ch  BoxLposi/100, BoxTposi/100,  BoxLposi/100+BoxLength/(XScanSize/1),BoxTposi/100+0.1
		//SetDrawEnv/W=Image1ch fsize=ScaleCap_Font, textrgb=(r,g,b ), fstyle=1//, fname=Cap_Font

		//	DrawText/w=Image1ch  ScaleBar_LPosi/100+ScaleCap_LPosi/100, ScaleBar_TPosi/100+ScaleCap_TPosi/100,  StrScale //-ScaleCap_TPosi/100
		//endif


	endif


	SetDataFolder SavedDataFolder


End

//Function AddScaleCap(index)
//	variable index
//
//	string SavedDataFolder = GetDataFolder(1)
//
//	SetDataFolder root:ViewVariables
//
//
//
//	if(index !=0)
//
//		SetDrawLayer/W=Image1ch/K USerFront
//
//		return 0
//
//	endif
//
//	NVAR ScaleFlag
//	NVAR ScaleBar_Unit
//	NVAR ScaleBar_Length
//	NVAR ScaleBar_Thickness
//	NVAR ScaleBar_LPosi
//	NVAR ScaleBar_TPosi
//
//	NVAR ScaleCap_Style
//	NVAR ScaleCap_LPosi
//	NVAR ScaleCap_TPosi
//	NVAR  ScaleCap_Font
//
//
//	NVAR MovieSize
//
//	NVAR XScanSize
//
//
//
//
//	DoWIndow/F Image1ch
//	DoAutoSizeImage( MovieSize,1)
//
//	NVAR  TimeCap_Color
//	variable r, g,b
//
//	if(TimeCap_Color==1)
//		r=65535
//		g=65535
//		b=65535
//	elseif(TimeCap_Color==2)
//		r=0
//		g=0
//		b=0
//	elseif(TimeCap_Color==3)
//		r=65535
//		g=0
//		b=0
//	elseif(TimeCap_Color==4)
//		r=0
//		g=0
//		b=65535
//	endif
//
//
//
//	String StrScale
//	variable ValScale
//	variable ScaleFactor
//
//	NVAR  TimeCap_Font
//
//	if(TimeCap_Font==1)
//		StrScale ="\F'Arial'"
//	elseif(TimeCap_Font==2)
//		StrScale ="\F'Times'"
//	endif
//
//
//	if(ScaleBar_Unit==1)
//
//		ScaleFactor=1
//		ValScale=round(XScanSize*ScaleBar_Length/100)
//		StrScale +=num2str(ValScale)
//		StrScale +=" nm"
//
//	elseif(ScaleBar_Unit==2)
//
//		ScaleFactor=1000
//		ValScale=round(XScanSize*ScaleBar_Length/100/1000)
//		StrScale +=num2str(ValScale)
//
//		if(TimeCap_Font==1)
//			StrScale +=" \F'Symbol'm\F'Arial'm"
//		else
//			StrScale +=" \F'Symbol'm\F'Times'm"
//		endif
//
//		//\F'Symbol'm\F'Arial'm
//	endif
//
//
//	DoWindow Image1ch
//	if(V_Flag==1)
//
//		SetDrawLayer/W=Image1ch/K USerFront
//		SetDrawLayer/W=Image1ch USerFront
//
//		SetDrawEnv/W=Image1ch linethick=ScaleBar_Thickness, xcoord=prel, ycoord=prel, linefgc=(r,g,b)
//		DrawLine/W=Image1ch ScaleBar_LPosi/100, ScaleBar_TPosi/100, ScaleBar_LPosi/100+ValScale/(XScanSize/ScaleFactor),ScaleBar_TPosi/100
//
//
//		SetDrawEnv/W=Image1ch fsize=ScaleCap_Font, textrgb=(r,g,b ), fstyle=1, fname=Cap_Font
//
//		DrawText/w=Image1ch    ScaleBar_LPosi/100+ScaleCap_LPosi/100, ScaleBar_TPosi/100+ScaleCap_TPosi/100,  StrScale //-ScaleCap_TPosi/100
//
//		print ScaleCap_TPosi
//		//DrawText/w=Image1ch  0.5, 0, StrScale
//		//TextBox/w=Image1ch/C/B=1/N=text2/F=0/A=RB/G=(r,g,b)/M  StrScale
//
//
//
//	endif
//
//
//	DoWindow Image2ch
//	if(V_Flag==1)
//
//	endif
//
//	SetDataFolder SavedDataFolder
//
//
//End

Function OpenFilesAgain(checkflag)
	variable checkflag

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables

	variable i

	String ImageFileList
	NVAR FileNum=root:ViewVariables:FileNum
	NVAR  DataVer=root:ViewVariables:DataVer //0; Old, 1:New
	NVAR FileOpenCheck=root:ViewVariables:FileOpenCheck
	SVAR ImageFilePath
	NVAR CheckSubFolder
	if(CheckSubFolder==1)


		PathInfo ParentFolderForSub
		ImageFilePath=S_Path
		NewPath/O/Q ViewPath,  ImageFilePath

		ImageFileList = IndexedFile(ViewPath,-1,".asd")

		FileNum=ItemsInList(ImageFileList, ";")

		String SubFolder_All
		SubFolder_All=IndexedDir("ViewPath", -1, 0)

		variable FolderNum
		FolderNum=ItemsInList(SubFolder_All, ";")

		variable folder
		String CheckFolder

		for(folder=0; folder<FolderNum; folder+=1)

			CheckFolder=IndexedDir("ViewPath", folder, 0)
			PathInfo ViewPath
			ImageFilePath=S_Path

			ImageFilePath +=CheckFolder
			ImageFilePath +=":"

			NewPath/O/Q CheckFolderPath,  ImageFilePath
			ImageFileList = IndexedFile(CheckFolderPath,-1,".asd")

			FileNum +=ItemsInList(ImageFileList, ";")

		endfor

		Make/O/N=(FileNum) ImageListBuddy
		Make/T/O/T/N=(FileNum) ImageList
		Make/T/O/T/N=(FileNum) FolderList

		ImageFileList = IndexedFile(ViewPath,-1,".asd")

		FileNum=ItemsInList(ImageFileList, ";")


		PathInfo ViewPath
		ImageFilePath=S_Path

		variable FileCount
		FileCount=0

		for(i=0;i<FileNum; i+=1)

			ImageList[FileCount]=StringFromList(i, ImageFileList)
			ImageListBuddy[FileCount]=0
			FolderList[FileCount]=ImageFilePath

			FileCount+=1
			//ImageList=AddListItem(FileName+"_1","", ";",i)
		Endfor

		for(folder=0; folder<FolderNum; folder+=1)

			CheckFolder=IndexedDir("ViewPath", folder, 0)
			PathInfo ViewPath
			ImageFilePath=S_Path

			ImageFilePath +=CheckFolder
			ImageFilePath +=":"

			NewPath/O/Q CheckFolderPath,  ImageFilePath
			ImageFileList = IndexedFile(CheckFolderPath,-1,".asd")
			FileNum=ItemsInList(ImageFileList, ";")
			for(i=0;i<FileNum; i+=1)

				ImageList[FileCount]=StringFromList(i, ImageFileList)
				ImageListBuddy[FileCount]=0
				FolderList[FileCount]=ImageFilePath
				FileCount+=1
			Endfor
		endfor

		FileNum=Dimsize(ImageList,0)

		if(FileCount<0)

			return 0

		endif
		//ValDisplay ShowIndex, disable=0
		ValDisplay ShowTotalNum, win=MainViewPanel, disable=0
		ControlInfo ImageSlider
		if(V_Flag !=0)

			Slider ImageSlider,  win=MainViewPanel, disable=0
		endif


		ImageFileList = IndexedFile(ViewPath,-1,".asd")

		ListBox ImageList, win=MainViewPanel,font="Arial",fsize=6,frame=2,mode=4,selWave=root:ViewVariables:ImageListBuddy

		ListBox ImageList,win=MainViewPanel,listWave=root:ViewVariables:ImageList, proc=ImageDisplayListFuncAction

		SVAR TextDisplayStringPath=root:ViewVariables:TextDisplayStringPath

		//Make/T/O textOutputWave
		//Wave/T  textOutputWave=root:ViewVariables:textOutputWave

		string ImagePath
		ImagePath=FolderList[0]

		if(DimSize(FolderList,0)==0)

			return 0
		endif

		//ConvertGlobalStringTextEncoding 4,1, ImagePath

		textDisplayStringPath = WrapText(ImagePath, 50)


		NVAR OldImageFileIndex

		OldImageFileIndex=-1

		FileOpenCheck+=1


		KillPath/Z CheckFolderPath

		NVAR ImageFileIndex=root:ViewVariables:ImageFileIndex

		if(Dimsize(ImageListBuddy,0)==ImageFileIndex)
			ImageFileIndex -=1
		endif
		//if(CheckFlag==0 && ImageFileIndex>1)
		//ImageFileIndex -=1
		//endif
		ImageListBuddy[ImageFileIndex]=1
		ListBoxUpdate(1,ImageFileIndex, 0)


		return 0
	endif

	////////////

	PathInfo ViewPath
	ImageFilePath=S_Path

	DataVer=0
	ImageFileList= IndexedFile(ViewPath,-1,".daf")

	strswitch(ImageFileList)
		case "":
			DataVer=1
			break
	endswitch
	if(DataVer==0)
		DoAlert 1, "�f�[�^���Â����܂�"

		ValDisplay ShowIndex, win=MainViewPanel, disable=1
		ValDisplay ShowTotalNum, win=MainViewPanel, disable=1
		ControlInfo ImageSlider
		if(V_Flag !=0)
			Slider ImageSlider,  win=MainViewPanel, disable=1
		endif
	endif

	if(DataVer==1)

		//ValDisplay ShowIndex, disable=0
		ValDisplay ShowTotalNum, win=MainViewPanel, disable=0
		ControlInfo ImageSlider
		if(V_Flag !=0)
			Slider ImageSlider,  win=MainViewPanel, disable=0
		endif


		ImageFileList = IndexedFile(ViewPath,-1,".asd")
	endif

	strswitch(ImageFileList)	// string switch
		case "":		// execute if case matches expression

			ControlInfo /W=MainViewPanel ImageSlider

			DoWindow/K MainViewPanel

			DoWindow Image1ch
			if(V_Flag==1)
				DoWindow/K Image1ch
			endif

			DoWindow Image2ch
			if(V_Flag==1)
				DoWindow/K Image2ch
			endif

			//DoWindow/K EditPanel

			MakeViewPanel(0)

			DoWindow/K EditPanel
			//if(V_Flag !=0)
			//	KillCOntrol/W=MainViewPanel ImageSlider
			//endif
			return 0
			break
	endswitch

	FileNum=ItemsInList(ImageFileList, ";")
	variable k=0, CheckResult
	string checkstring
	if(DataVer==0)
		for (i=0; i<FileNum; i+=1)
			//	Check=0
			checkstring=StringFromList(k, ImageFileList)
			CheckResult=strsearch(checkstring,"2ch", 0)

			if(CheckResult != -1)

				ImageFileList=RemoveListItem(k,  ImageFileList,";")
				//	Check=1

			endif
			if(CheckResult== -1)
				k +=1
			endif
			//	if(Check==1)
			//		break
			//	endif

		Endfor
	endif

	FileNum=ItemsInList(ImageFileList, ";")
	Make/O/N=(FileNum) ImageListBuddy
	Make/T/O/T/N=(FileNum) ImageList
	//SVAR ImageList=root:ViewVariables:ImageList


	for(i=0;i<FileNum; i+=1)

		ImageList[i]=StringFromList(i, ImageFileList)
		ImageListBuddy[i]=0
		//ImageList=AddListItem(FileName+"_1","", ";",i)


	Endfor

	ListBox ImageList, win=MainViewPanel, font="Arial",fsize=6,frame=2,mode=4,selWave=root:ViewVariables:ImageListBuddy
	ListBox ImageList, win=MainViewPanel, listWave=root:ViewVariables:ImageList, proc=ImageDisplayListFuncAction



	SVAR TextDisplayStringPath=root:ViewVariables:TextDisplayStringPath

	Make/T/O textOutputWave
	Wave/T  textOutputWave=root:ViewVariables:textOutputWave

	ConvertGlobalStringTextEncoding/CONV=4 4,1, ImageFilePath

   textDisplayStringPath = WrapText(ImageFilePath, 50)

	NVAR OldImageFileIndex

	OldImageFileIndex=-1

	FileOpenCheck+=1



	SetDataFolder SavedDataFolder

end

/////////////////////  Editer

Function MakeEditPanel() : Panel

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables

	DoWIndow Image1ch

	if(V_flag==0)

		doAlert 0, "Load image files"
		return 0
	endif

	DoWIndow/F EditPanel

	if(V_flag==1)
		return 0
	endif


	Wave EditPanelParams=root:EditP


	NewPanel /k=1/W=(1250,50,1670,285) as "EditPanel"

	PauseUpdate; Silent 1		// building window...
	DoWindow/C/T EditPanel "Edit Panel"

	//MoveWIndow TrackingPanel  350, 50, 350+
	MoveWindow/W=EditPanel EditPanelParams[0], EditPanelParams[1], EditPanelParams[2], EditPanelParams[3]

	///////////////Comment SubWindow

	TitleBox  TitleComment, win=EditPanel, pos={130,20}, frame=0, fstyle=1, title="Comment"
	NewNotebook /F=1 /N=EditCommentNote /HOST=EditPanel /W=(130,40,420,310) as "EditCommentNote"

	SVAR Comment=root:ViewVariables:Comment
	NoteBook EditPanel#EditCommentNote text=Comment

	//OpenNotebook/Z/N=CommentNoteBackUp/P=FalconViewerPath/V=1  "CommentNote.txt"

	//NoteBook CommentNoteBackUp selection={StartOfFile, endOfFile}
	//GetSelection notebook, CommentNoteBackUp, 2
	//String CommentBack=S_selection


	Button ButtonCommentEdit,win=EditPanel,  pos={20,30},size={85,40},title="Comment Edit", proc=ButtonCommentEditProc

	Button ButtonTrimtEdit,win=EditPanel,  pos={20,80},size={70,40},title="Trim", proc=ButtonTrimtEditProc

	Button ButtonClipEdit, win=EditPanel, pos={20,130},size={70,40},title="Clip", proc=ButtonClipEditProc

	Button ButtonConcpEdit, win=EditPanel, pos={20,180},size={70,40},title="Concanate", proc=ButtonConcEditProc

	Button ButtonMarkEdit, win=EditPanel, pos={20,230},size={70,40},title="Mark", proc=ButtonMarkEditProc

	//Button ButtonCombineEdit, win=EditPanel, pos={20,180},size={70,40},title="Combine", proc=ButtonCombineEditProc

	//Button ButtonDivideEdit, win=EditPanel, pos={20,180},size={70,40},title="Divide", proc=ButtonDivideEditProc

	//Button ButtonBackEdit, win=EditPanel, pos={20,230},size={90,40},title="Back to Original", proc=ButtonBackEditProc, fcolor=(65535,0,0)

	Button ButtonKillFile, win=EditPanel,  pos={10,320},size={50,30},title="Kill lFile", proc=ButtonKillFileProc, fcolor=(1,1,1)

	NVAR CheckShowKilledFile

	CheckBox CheckShowKilledFile,win=EditPanel,  pos={70,326}, title="Show Killed Files", variable=CheckShowKilledFile, proc=CheckShowKilledFileProc

	if(CheckShowKilledFile==1)
		CheckShowKilledFileProc("",CheckShowKilledFile)

	endif

	//KillWindow CommentNoteBackUp


	SetDataFolder SavedDataFolder

End

Function ButtonCommentEditProc(ba) : ButtonControl
	STRUCT WMButtonAction &ba

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables


	switch( ba.eventCode )
		case 2: // mouse up

			//SVAR SComment=root:ViewVariables:TextDisplayStringComment
			//NoteBook EditPanel#CommentNote text=SComment
			//SaveNotebook/O/P=FalconViewerPath/S=6  EditPanel#EditCommentNote  as "EditCommentNote.txt"

			SVAR Comment=root:ViewVariables:Comment

			NoteBook  EditPanel#EditCommentNote selection={StartOfFile, endOfFile}
			GetSelection notebook,  EditPanel#EditCommentNote, 2
			Comment =S_selection

			//SComment +="\r ########## Comment Edited"
			NVAR  CommentEdit_Tag
			CommentEdit_Tag=1

			DoWIndow EditPanel

			SaveEditedASD()
			// click code here
			break
	endswitch

	SetDataFolder SavedDataFolder
	return 0
End

Function ButtonTrimtEditProc(ba) : ButtonControl
	STRUCT WMButtonAction &ba

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables


	switch( ba.eventCode )
		case 2: // mouse up


			NVAR FirstFrame
			NVAR LastFrame
			NVAR  FrameNum

			if(FrameNum-(abs(LastFrame-FirstFrame)+1)<=0)
				doAlert 0, "Can't trim!"
				return 0
			endif

			NVAR  TrimEdit_Tag
			TrimEdit_Tag=1

			DoWIndow EditPanel

			SaveEditedASD()
			// click code here
			break
	endswitch

	SetDataFolder SavedDataFolder
	return 0
End

Function ButtonClipEditProc(ba) : ButtonControl
	STRUCT WMButtonAction &ba

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables


	switch( ba.eventCode )
		case 2: // mouse up


			NVAR FirstFrame
			NVAR LastFrame
			NVAR  FrameNum

			if(abs(LastFrame-FirstFrame)+1<=0)
				doAlert 0, "Can't Clip!"
				return 0
			endif

			NVAR ClipEdit_Tag
			ClipEdit_Tag=1

			DoWIndow EditPanel

			SaveEditedASD()
			// click code here
			break
	endswitch

	SetDataFolder SavedDataFolder
	return 0
End


Function ButtonConcEditProc(ba) : ButtonControl
	STRUCT WMButtonAction &ba

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables



	switch( ba.eventCode )
		case 2: // mouse up


			NVAR FirstFrame
			NVAR LastFrame
			NVAR  FrameNum

			SVAR FileName
			String/G FileName2

			Wave ImageListBuddy
			Wave/T ImageList

			SVAR ImageFilePath=root:ViewVariables:ImageFilePath
			SVAR Path=root:ViewVariables:Path

			NVAR XPixel
			NVAR YPIxel
			NVAR XScanSize
			NVAR YScanSize
			NVAR FrameTime

			variable i, ret
			variable/G ConFileNum=0

			variable PreXPixel
			variable PreYPixel
			variable PreXScanSize
			variable PreYScanSize
			variable PreFrameTime

			for(i=0; i<numpnts(ImageListBuddy); i+=1)

				if( ImageListBuddy[i]==1)


					ConFileNum +=1

					FileName=ImageList[i]


					NVAR CheckSubFolder

					ret=tu_OpenNewFile()


					if(ConFileNum>1)

						if(PreXPixel != XPixel || PreYPixel != YPixel ||  PreXScanSize != XScanSize || PreYScanSize != YScanSize ||  PreFrameTime != FrameTime )

							DoAlert 1, "Inconsistent file properties!"

							return 0
						endif

					endif

					if(ConFileNum>2)

						DoAlert 1, "Too many files!"

						return 0

					endif

					PreXPixel=XPixel
					PreYPixel=YPixel
					PreXScanSize=XScanSize
					PreYScanSize=YScanSize
					PreFrameTime =FrameTime


				endif

			endfor

			ConFileNum=0

			for(i=0; i<numpnts(ImageListBuddy); i+=1)

				if( ImageListBuddy[i]==1)


					ConFileNum +=1

					if(ConFileNum ==1)
						FileName=ImageList[i]
					endif

					if(ConFileNum ==2)
						FileName2=ImageList[i]
					endif
				endif


			endfor




			NVAR ConcEdit_Tag
			ConcEdit_Tag=1

			DoWIndow EditPanel

			SaveConcASD()
			// click code here
			break
	endswitch

	SetDataFolder SavedDataFolder
	return 0
End

Function ButtonMarkEditProc(ba) : ButtonControl
	STRUCT WMButtonAction &ba

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables

	String ImageFileList
	NVAR FileNum=root:ViewVariables:FileNum
	NVAR  DataVer=root:ViewVariables:DataVer //0; Old, 1:New
	NVAR FileOpenCheck=root:ViewVariables:FileOpenCheck

	SVAR ImageFilePath
	variable i



	switch( ba.eventCode )
		case 2: // mouse up
			SVAR FileName=root:ViewVariables:FileName
			String ChangedName

			ChangedName=FileNameOnly(FileName)+"#"+".asd"

			GetFileFolderInfo/P=ViewPath/Q/Z FileName
			if(V_Flag<0)

				DoAlert 1, "Select File!"

				return 0
			endif

			MoveFIle/O/P=ViewPath  FileName ChangedName
			//SetFileFolderInfo/P=ViewPath/inv=1 ChangedName


			OpenFilesAgain(0)
			//ImageFileOpen()

			// click code here
			break
	endswitch

	SetDataFolder SavedDataFolder
	return 0
End

Function ButtonCombineEditProc(ba) : ButtonControl
	STRUCT WMButtonAction &ba

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables


	switch( ba.eventCode )
		case 2: // mouse up


			//	NVAR FirstFrame
			//	NVAR LastFrame
			//	NVAR  FrameNum

			//	if(abs(LastFrame-FirstFrame)+1<=0)
			//		doAlert 0, "Can't Clip!"
			//		return 0
			//	endif

			//	NVAR ClipEdit_Tag
			//	ClipEdit_Tag=1

			//	DoWIndow EditPanel

			SaveEditedASD()
			// click code here
			break
	endswitch

	SetDataFolder SavedDataFolder
	return 0
End

Function ButtonDivideEditProc(ba) : ButtonControl
	STRUCT WMButtonAction &ba

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables


	switch( ba.eventCode )
		case 2: // mouse up


			NVAR FirstFrame
			NVAR LastFrame
			NVAR  FrameNum

			if(FirstFrame ==0  || FirstFrame==FrameNum-1)

				doAlert 0, "Frame is not appropriate!"
				return 0
			endif

			//if(abs(LastFrame-FirstFrame)+1<=0)
			//	doAlert 0, "Can't Clip!"
			//	return 0
			///endif

			NVAR DivideEdit_Tag
			DivideEdit_Tag=1

			DoWIndow EditPanel

			SaveEditedASD()
			// click code here
			break
	endswitch

	SetDataFolder SavedDataFolder
	return 0
End

Function ButtonBackEditProc(ba) : ButtonControl
	STRUCT WMButtonAction &ba

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables


	switch( ba.eventCode )
		case 2: // mouse up
			SVAR FileName=root:ViewVariables:FileName
			String ChangedName=FileName +"_Origin"

			GetFileFolderInfo/P=ViewPath/Q/Z=1 ChangedName
			if(v_flag<0)
				doAlert 0, "No Original File"
				return 0
			endif

			MoveFIle/O/P=ViewPath  ChangedName  FileName

			SetFileFolderInfo/P=ViewPath/inv=0 FileName

			ImageFileOpen()

			// click code here
			break
	endswitch

	SetDataFolder SavedDataFolder
	return 0
End

Function ButtonRestoreFileProc(ba) : ButtonControl
	STRUCT WMButtonAction &ba

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables

	variable i
	string S_KilledFilePath

	String ChangedName
	String FileName
	variable count

	count=0

	switch( ba.eventCode )
		case 2: // mouse up

			Wave KilledListBuddy
			Wave/T KilledList
			Wave/T KilledFolderList

			Make/O/N=0 Temp_KilledListBuddy
			Make/T/O/T/N=0 Temp_KilledList
			Make/T/O/T/N=0 Temp_KilledFolderList

			for(i=0;i<Dimsize(KilledListBuddy,0);i+=1)

				if(KilledListBuddy[i]==1)

					S_KilledFilePath=KilledFolderList[i]

					NewPath/O/Q KilledFilePath, S_KilledFilePath

					FileName=KilledList[i]

					ChangedName=RemoveEnding(FileName, "_x")

					MoveFIle/O/P=KilledFilePath  FileName ChangedName
					SetFileFolderInfo/P=KilledFilePath/inv=0 ChangedName


				else

					Insertpoints DimSize(Temp_KilledListBuddy,0),1,Temp_KilledListBuddy
					Insertpoints DimSize(Temp_KilledList,0),1,Temp_KilledList
					Insertpoints DimSize(Temp_KilledFolderList,0),1,Temp_KilledFolderList

					Temp_KilledListBuddy[count]=KilledListBuddy[i]
					Temp_KilledList[count]=KilledList[i]
					Temp_KilledFolderList[count]=KilledFolderList[i]

					count+=1

				endif



			endfor

			Duplicate/O Temp_KilledListBuddy, KilledListBuddy
			Duplicate/O/T Temp_KilledList, KilledList
			Duplicate/O/T Temp_KilledFolderList, KilledFolderList

			KillWaves/Z Temp_KilledListBuddy
			KillWaves/Z Temp_KilledList
			KillWaves/Z Temp_KilledFolderList

			// click code here

			////////

			OpenFilesAgain(1)

			///////
			break
	endswitch

	SetDataFolder SavedDataFolder
	return 0
End

Function ButtonKillFileProc(ba) : ButtonControl
	STRUCT WMButtonAction &ba

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables

	String ImageFileList
	NVAR FileNum=root:ViewVariables:FileNum
	NVAR  DataVer=root:ViewVariables:DataVer //0; Old, 1:New
	NVAR FileOpenCheck=root:ViewVariables:FileOpenCheck

	SVAR ImageFilePath
	variable i



	switch( ba.eventCode )
		case 2: // mouse up
			SVAR FileName=root:ViewVariables:FileName
			String ChangedName=FileName +"_x"

			GetFileFolderInfo/P=ViewPath/Q/Z FileName
			if(V_Flag<0)

				DoAlert 1, "Select File!"

				return 0
			endif

			MoveFIle/O/P=ViewPath  FileName ChangedName
			SetFileFolderInfo/P=ViewPath/inv=1 ChangedName


			OpenFilesAgain(0)
			//ImageFileOpen()

			// click code here
			break
	endswitch

	SetDataFolder SavedDataFolder
	return 0
End

Function CheckEditPanel()

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables

	DoWIndow EditPanel

	if(V_flag==1)

		//	DoWIndow/K EditPanel

		//MakeEditPanel()
		SVAR Comment=root:ViewVariables:Comment

		Notebook EditPanel#EditCommentNote  selection={startOfFile, endOfFile}

		NoteBook EditPanel#EditCommentNote text=Comment

		return 0
	endif

	//TitleBox  TitleComment, win=EditPanel, pos={200,20}, frame=0, fstyle=1, title="Comment"
	//DoWIndow/K EditPanel#CommentNote
	//NewNotebook/F=1 /N=CommentNote /HOST=EditPanel /W=(200,40,520,310) as "CommentNote"

	//SVAR SComment=root:ViewVariables:TextDisplayStringComment
	//SComment=""
	//NoteBook EditPanel#CommentNote text=SComment


	SetDataFolder SavedDataFolder

End

Function SaveEditedASD_Back()

	variable ret

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables


	SVAR Comment=root:ViewVariables:Comment


	NVAR  CommentEdit_Tag=root:ViewVariables:CommentEdit_Tag

	if(CommentEdit_Tag==1)
		Comment +="\r## Comment Edited ## : "+date()
	endif

	NVAR  TrimEdit_Tag=root:ViewVariables:TrimEdit_Tag
	NVAR  ClipEdit_Tag=root:ViewVariables:ClipEdit_Tag
	NVAR  DivideEdit_Tag=root:ViewVariables:DivideEdit_Tag
	NVAR FirstFrame
	NVAR LastFrame

	if(TrimEdit_Tag==1)
		Comment +="\r## Trimed ## : "+date()
		Comment +="\r From "
		Comment += num2str(FirstFrame)
		Comment +=" To "
		Comment += num2str(LastFrame)
	endif


	if(ClipEdit_Tag==1)
		Comment +="\r## Clipped ## : "+date()
		Comment +="\r From "
		Comment += num2str(FirstFrame)
		Comment +=" To "
		Comment += num2str(LastFrame)
	endif


	if(DivideEdit_Tag==1)
		Comment +="\r## Divided ## : "+date()
		Comment +="\r At "
		Comment += num2str(FirstFrame)
	endif


	SVAR FileName=root:ViewVariables:FileName

	if(DivideEdit_Tag !=1)

		String/G SaveFileName
		SaveFileName=FileNameOnly(FileName)+"_Temp"+".asd"

	elseif(DivideEdit_Tag ==1)

		String/G SaveFileName_1
		String/G SaveFileName_2
		SaveFileName_1=FileNameOnly(FileName)+"_D1"+".asd"
		SaveFileName_2=FileNameOnly(FileName)+"_D2"+".asd"

	Endif

	ret=tu_SaveAsEditedASD()
	if(ret==1)
		DoAlert 1, "Error:td_SaveAsEditedASD: Don't use Japanese words as the data folder!"
		return 0
	endif

	SVAR FileName=root:ViewVariables:FileName
	String ChangedName

	if(DivideEdit_Tag==1)
		KillStrings/Z SaveFileName_1
		KillStrings/Z  SaveFileName_2

		ChangedName=FileName +"_x"
	else
		ChangedName=FileName +"_Origin"

	endif

	GetFileFolderInfo/P=ViewPath/Q/Z=1 ChangedName
	if(v_flag<0)

		MoveFIle/O/P=ViewPath FileName ChangedName

		SetFileFolderInfo/P=ViewPath/inv=1 ChangedName

	endif

	if(DivideEdit_Tag==0)
		MoveFIle/O/P=ViewPath SaveFileName  FileName
	endif

	CommentEdit_Tag=0
	TrimEdit_Tag=0
	ClipEdit_Tag=0
	DivideEdit_Tag=0


	////////////
	NVAR  CheckSubFolder
	if(CheckSubFolder==1)
		OpenSubFolderAfterEdit()
		ImageFileOpen()
		return 0

	endif

	NVAR  DataVer=root:ViewVariables:DataVer //0; Old, 1:New

	SVAR ImageFilePath
	String ImageFileList
	NVAR FileNum

	PathInfo ViewPath
	ImageFilePath=S_Path

	//if (V_flag)
	//	return 1
	//endif
	DataVer=0
	ImageFileList= IndexedFile(ViewPath,-1,".daf")
	strswitch(ImageFileList)
		case "":
			DataVer=1
			break
	endswitch
	if(DataVer==0)
		DoAlert 1, "�f�[�^���Â����܂�"

		ValDisplay ShowIndex, disable=1
		ValDisplay ShowTotalNum, disable=1
		ControlInfo ImageSlider
		if(V_Flag !=0)

			Slider ImageSlider,  win=MainViewPanel, disable=1
		endif

	endif

	if(DataVer==1)

		//ValDisplay ShowIndex, disable=0
		ValDisplay ShowTotalNum, disable=0
		ControlInfo ImageSlider
		if(V_Flag !=0)

			Slider ImageSlider,  win=MainViewPanel, disable=0
		endif


		ImageFileList = IndexedFile(ViewPath,-1,".asd")
	endif

	strswitch(ImageFileList)	// string switch
		case "":		// execute if case matches expression

			ControlInfo /W=MainViewPanel ImageSlider
			//if(V_Flag !=0)
			//	KillCOntrol/W=MainViewPanel ImageSlider
			//endif
			return 0
			break
	endswitch

	FileNum=ItemsInList(ImageFileList, ";")
	variable i,k=0, CheckResult
	string checkstring
	if(DataVer==0)
		for (i=0; i<FileNum; i+=1)
			//	Check=0
			checkstring=StringFromList(k, ImageFileList)
			CheckResult=strsearch(checkstring,"2ch", 0)

			if(CheckResult != -1)

				ImageFileList=RemoveListItem(k,  ImageFileList,";")
				//	Check=1

			endif
			if(CheckResult== -1)
				k +=1
			endif
			//	if(Check==1)
			//		break
			//	endif

		Endfor
	endif

	FileNum=ItemsInList(ImageFileList, ";")
	Make/O/N=(FileNum) ImageListBuddy
	Make/T/O/T/N=(FileNum) ImageList
	Make/T/O/T/N=(FileNum) FolderList
	//SVAR ImageList=root:ViewVariables:ImageList


	for(i=0;i<FileNum; i+=1)

		ImageList[i]=StringFromList(i, ImageFileList)
		ImageListBuddy[i]=0
		FolderList[i]=ImageFilePath
		//ImageList=AddListItem(FileName+"_1","", ";",i)


	Endfor


	//////////////
	ImageFileOpen()

	SetDataFolder SavedDataFolder
	return 0

End

Function SaveConcASD()

	variable ret

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables


	SVAR Comment=root:ViewVariables:Comment


	NVAR  CommentEdit_Tag=root:ViewVariables:CommentEdit_Tag
	SVAR  FileName=root:ViewVariables:FileName
	SVAR  FileName2=root:ViewVariables:FileName2



	Comment +="\r## Concanated ## : "+date()
	Comment +="\r"+FileName + " + " + FileName2


	string TempFileName

	TempFileName=FileNameOnly(FileName2)

	Variable BarPos=searchBackwards(TempFileName,"_")
	variable len= strlen(TempFileName)

	String FileNo=TempFileName[BarPos+1, len]


	String/G SaveFileName

	SaveFileName=FileNameOnly(FileName)+"_"+FileNo+".asd"


	//SaveFileName=FileNameOnly(FileName)+"_T"+".asd"


	//elseif(DivideEdit_Tag ==1)

	//String/G SaveFileName_1
	////String/G SaveFileName_2
	//SaveFileName_1=FileNameOnly(FileName)+"_D1"+".asd"
	//SaveFileName_2=FileNameOnly(FileName)+"_D2"+".asd"

	//Endif

	ret=tu_SaveAsConcASD()
	if(ret==1)
		DoAlert 1, "Error:td_SaveAsEditedASD: Don't use Japanese words as the data folder!"
		return 0
	endif

	SVAR FileName=root:ViewVariables:FileName
	String ChangedName

	//if(DivideEdit_Tag==1)
	//KillStrings/Z SaveFileName_1
	//KillStrings/Z  SaveFileName_2

	//ChangedName=FileName +"_x"
	//else
	//ChangedName=FileName +"_Origin"

	//endif

	//GetFileFolderInfo/P=ViewPath/Q/Z=1 ChangedName
	//if(v_flag<0)

	//	MoveFIle/O/P=ViewPath FileName ChangedName

	//	SetFileFolderInfo/P=ViewPath/inv=1 ChangedName

	//endif

	//if(DivideEdit_Tag==0)
	//MoveFIle/O/P=ViewPath SaveFileName  FileName
	//endif


	Wave ImageListBuddy=root:ViewVariables:ImageListBuddy
	NVAR ImageIndex=root:ViewVariables:ImageIndex
	variable LastImageIndex
	variable LastFrameNum
	variable position



	////////////
	NVAR  CheckSubFolder
	if(CheckSubFolder==1)

		LastImageIndex=ImageIndex

		FindValue/V=1 ImageListBuddy

		position= V_value

		if(position <0)

			position=0

		endif

		OpenSubFolderAfterEdit()
		ImageFileOpen()

		ImageListBuddy[position]=1

		//Wave/T ImageList=root:ViewVariables:ImageList
		ImageIndex= LastFrameNum//LastImageIndex

		ShowImage(0)


		return 0

	endif

	NVAR  DataVer=root:ViewVariables:DataVer //0; Old, 1:New

	SVAR ImageFilePath
	String ImageFileList
	NVAR FileNum

	PathInfo ViewPath
	ImageFilePath=S_Path

	//if (V_flag)
	//	return 1
	//endif
	DataVer=0
	ImageFileList= IndexedFile(ViewPath,-1,".daf")
	strswitch(ImageFileList)
		case "":
			DataVer=1
			break
	endswitch
	if(DataVer==0)
		DoAlert 1, "�f�[�^���Â����܂�"

		ValDisplay ShowIndex, disable=1
		ValDisplay ShowTotalNum, disable=1
		ControlInfo ImageSlider
		if(V_Flag !=0)

			Slider ImageSlider,  win=MainViewPanel, disable=1
		endif

	endif

	if(DataVer==1)

		//ValDisplay ShowIndex, disable=0
		ValDisplay ShowTotalNum,  win=MainViewPanel,  disable=0
		ControlInfo/W=MainViewPanel ImageSlider
		if(V_Flag !=0)

			Slider ImageSlider,  win=MainViewPanel, disable=0
		endif


		ImageFileList = IndexedFile(ViewPath,-1,".asd")
	endif

	strswitch(ImageFileList)	// string switch
		case "":		// execute if case matches expression

			ControlInfo /W=MainViewPanel ImageSlider
			//if(V_Flag !=0)
			//	KillCOntrol/W=MainViewPanel ImageSlider
			//endif
			return 0
			break
	endswitch

	FileNum=ItemsInList(ImageFileList, ";")
	variable i,k=0, CheckResult
	string checkstring
	if(DataVer==0)
		for (i=0; i<FileNum; i+=1)
			//	Check=0
			checkstring=StringFromList(k, ImageFileList)
			CheckResult=strsearch(checkstring,"2ch", 0)

			if(CheckResult != -1)

				ImageFileList=RemoveListItem(k,  ImageFileList,";")
				//	Check=1

			endif
			if(CheckResult== -1)
				k +=1
			endif
			//	if(Check==1)
			//		break
			//	endif

		Endfor
	endif

	FileNum=ItemsInList(ImageFileList, ";")
	Make/O/N=(FileNum) ImageListBuddy
	Make/T/O/T/N=(FileNum) ImageList
	Make/T/O/T/N=(FileNum) FolderList
	//SVAR ImageList=root:ViewVariables:ImageList


	for(i=0;i<FileNum; i+=1)

		ImageList[i]=StringFromList(i, ImageFileList)
		ImageListBuddy[i]=0
		FolderList[i]=ImageFilePath
		//ImageList=AddListItem(FileName+"_1","", ";",i)


	Endfor


	//////////////


	Wave ImageListBuddy=root:ViewVariables:ImageListBuddy
	NVAR ImageIndex=root:ViewVariables:ImageIndex
	LastImageIndex=ImageIndex

	FindValue/V=1 ImageListBuddy

	position= V_value



	ImageFileOpen()

	if(position <0)

		position=0


	endif

	ImageListBuddy[position]=1

	//Wave/T ImageList=root:ViewVariables:ImageList
	ImageIndex= LastFrameNum //LastImageIndex

	ShowImage(0)


	SetDataFolder SavedDataFolder
	return 0


End

Function SaveEditedASD()

	variable ret

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables


	SVAR Comment=root:ViewVariables:Comment


	NVAR  CommentEdit_Tag=root:ViewVariables:CommentEdit_Tag


	if(CommentEdit_Tag==1)

		Comment +="\r## Comment Edited ## : "+date()

		ConvertGlobalStringTextEncoding/CONV=4 1,4, Comment

	endif



	NVAR  TrimEdit_Tag=root:ViewVariables:TrimEdit_Tag
	NVAR  ClipEdit_Tag=root:ViewVariables:ClipEdit_Tag
	NVAR  DivideEdit_Tag=root:ViewVariables:DivideEdit_Tag
	NVAR FirstFrame
	NVAR LastFrame

	if(TrimEdit_Tag==1)
		Comment +="\r## Trimed ## : "+date()
		Comment +="\r From "
		Comment += num2str(FirstFrame)
		Comment +=" To "
		Comment += num2str(LastFrame)

		ConvertGlobalStringTextEncoding/CONV=4 1,4, Comment
	endif


	if(ClipEdit_Tag==1)
		Comment +="\r## Clipped ## : "+date()
		Comment +="\r From "
		Comment += num2str(FirstFrame)
		Comment +=" To "
		Comment += num2str(LastFrame)

		ConvertGlobalStringTextEncoding/CONV=4 1,4, Comment
	endif


	if(DivideEdit_Tag==1)
		Comment +="\r## Divided ## : "+date()
		Comment +="\r At "
		Comment += num2str(FirstFrame)
	endif


	SVAR FileName=root:ViewVariables:FileName


	String/G SaveFileName


	//SaveFileName=FileNameOnly(FileName)+"_T"+".asd"


	variable num
	if(TrimEdit_Tag ==1 || ClipEdit_Tag==1)

		for(num=1;num<=10;num+=1)

			if(TrimEdit_Tag==1)
				SaveFileName=FileNameOnly(FileName)+"_T"+num2str(num)+".asd"
			elseif(ClipEdit_Tag==1)
				SaveFileName=FileNameOnly(FileName)+"_C"+num2str(num)+".asd"
			endif

			GetFileFolderInfo/P=ViewPath/Q/Z=1 SaveFileName

			if(v_flag!=0)

				break
			endif


		endfor

	endif

	if(CommentEdit_Tag==1)
		SaveFileName=FileNameOnly(FileName)+"_Com"+".asd"
	endif

	//elseif(DivideEdit_Tag ==1)

	//String/G SaveFileName_1
	////String/G SaveFileName_2
	//SaveFileName_1=FileNameOnly(FileName)+"_D1"+".asd"
	//SaveFileName_2=FileNameOnly(FileName)+"_D2"+".asd"

	//Endif

	ret=tu_SaveAsEditedASD()
	if(ret==1)
		DoAlert 1, "Error:td_SaveAsEditedASD: Don't use Japanese words as the data folder!"
		return 0
	endif

	SVAR FileName=root:ViewVariables:FileName
	String ChangedName

	//if(DivideEdit_Tag==1)
	//KillStrings/Z SaveFileName_1
	//KillStrings/Z  SaveFileName_2

	//ChangedName=FileName +"_x"
	//else
	//ChangedName=FileName +"_Origin"

	//endif

	//GetFileFolderInfo/P=ViewPath/Q/Z=1 ChangedName
	//if(v_flag<0)

	//	MoveFIle/O/P=ViewPath FileName ChangedName

	//	SetFileFolderInfo/P=ViewPath/inv=1 ChangedName

	//endif

	//if(DivideEdit_Tag==0)
	//MoveFIle/O/P=ViewPath SaveFileName  FileName
	//endif

	if(ret==0 && CommentEdit_Tag==1)

		MoveFIle/O/P=ViewPath SaveFileName  FileName

	endif

	CommentEdit_Tag=0
	TrimEdit_Tag=0
	ClipEdit_Tag=0
	DivideEdit_Tag=0

	Wave ImageListBuddy=root:ViewVariables:ImageListBuddy
	NVAR ImageIndex=root:ViewVariables:ImageIndex
	variable LastImageIndex
	variable LastFrameNum
	variable position

	LastFrameNum=LastFrame

	////////////
	NVAR  CheckSubFolder
	if(CheckSubFolder==1)

		LastImageIndex=ImageIndex

		FindValue/V=1 ImageListBuddy

		position= V_value

		OpenSubFolderAfterEdit()
		ImageFileOpen()

		ImageListBuddy[position]=1

		//Wave/T ImageList=root:ViewVariables:ImageList
		ImageIndex= LastFrameNum//LastImageIndex

		ShowImage(0)


		return 0

	endif

	NVAR  DataVer=root:ViewVariables:DataVer //0; Old, 1:New

	SVAR ImageFilePath
	String ImageFileList
	NVAR FileNum

	PathInfo ViewPath
	ImageFilePath=S_Path

	//if (V_flag)
	//	return 1
	//endif
	DataVer=0
	ImageFileList= IndexedFile(ViewPath,-1,".daf")
	strswitch(ImageFileList)
		case "":
			DataVer=1
			break
	endswitch
	if(DataVer==0)
		DoAlert 1, "�f�[�^���Â����܂�"

		ValDisplay ShowIndex, disable=1
		ValDisplay ShowTotalNum, disable=1
		ControlInfo ImageSlider
		if(V_Flag !=0)

			Slider ImageSlider,  win=MainViewPanel, disable=1
		endif

	endif

	if(DataVer==1)

		//ValDisplay ShowIndex, disable=0
		ValDisplay ShowTotalNum, disable=0
		ControlInfo ImageSlider
		if(V_Flag !=0)

			Slider ImageSlider,  win=MainViewPanel, disable=0
		endif


		ImageFileList = IndexedFile(ViewPath,-1,".asd")
	endif

	strswitch(ImageFileList)	// string switch
		case "":		// execute if case matches expression

			ControlInfo /W=MainViewPanel ImageSlider
			//if(V_Flag !=0)
			//	KillCOntrol/W=MainViewPanel ImageSlider
			//endif
			return 0
			break
	endswitch

	FileNum=ItemsInList(ImageFileList, ";")
	variable i,k=0, CheckResult
	string checkstring
	if(DataVer==0)
		for (i=0; i<FileNum; i+=1)
			//	Check=0
			checkstring=StringFromList(k, ImageFileList)
			CheckResult=strsearch(checkstring,"2ch", 0)

			if(CheckResult != -1)

				ImageFileList=RemoveListItem(k,  ImageFileList,";")
				//	Check=1

			endif
			if(CheckResult== -1)
				k +=1
			endif
			//	if(Check==1)
			//		break
			//	endif

		Endfor
	endif

	FileNum=ItemsInList(ImageFileList, ";")
	Make/O/N=(FileNum) ImageListBuddy
	Make/T/O/T/N=(FileNum) ImageList
	Make/T/O/T/N=(FileNum) FolderList
	//SVAR ImageList=root:ViewVariables:ImageList


	for(i=0;i<FileNum; i+=1)

		ImageList[i]=StringFromList(i, ImageFileList)
		ImageListBuddy[i]=0
		FolderList[i]=ImageFilePath
		//ImageList=AddListItem(FileName+"_1","", ";",i)


	Endfor


	//////////////


	Wave ImageListBuddy=root:ViewVariables:ImageListBuddy
	NVAR ImageIndex=root:ViewVariables:ImageIndex
	LastImageIndex=ImageIndex

	FindValue/V=1 ImageListBuddy

	position= V_value



	ImageFileOpen()



	ImageListBuddy[position]=1

	//Wave/T ImageList=root:ViewVariables:ImageList
	ImageIndex= LastFrameNum //LastImageIndex

	ShowImage(0)


	SetDataFolder SavedDataFolder
	return 0

End

Function DoAutoSizeImageFalcon(forceSize,flipVert)
	variable forceSize,flipVert

	if( (forceSize != 0) )
		if( (forceSize<0.1) %| (forceSize>20) )
			Abort "Unlikely value for forceSize; usually 0 or between .1 and 20"
			return 0
		endif
	endif
	String imagename= ImageNameList("", ";")
	Variable p1= strsearch(imagename, ";", 0)
	if( p1 <= 0 )
		Abort "Graph contains no images"
		return 0
	endif

	// Remember input for next time
	String dfSav= GetDataFolder(1);
	NewDataFolder/O/S root:Packages
	NewDataFolder/O/S WMAutoSizeImages
	Variable/G forceSizeSav= forceSize
	Variable/G flipVertSav= flipVert
	SetDataFolder dfSav


	NVAR XScanSize=root:ViewVariables:XScanSize
	NVAR YScanSize=root:ViewVariables:YScanSize

	imagename= imagename[0,p1-1]
	Wave w= ImageNameToWaveRef("",imagename)
	Variable width= DimSize(w,0)
	Variable height= width*YScanSize/XScanSize //DimSize(w,1)
	do
		if( forceSize )
			height *= forceSize;
			width *= forceSize;
			break
		endif
		variable maxdim= max(height,width)
		NewDataFolder/S tmpAutoSizeImage
		Make/O sizes={20,50,100,200,600,1000,2000,10000,50000,100000}		// temp waves used as lookup tables
		Make/O scales={16,8,4,2,1,0.5,0.25,0.125,0.0626,0.03125}
		Variable nsizes= numpnts(sizes),scale= 0,i= 0
		do
			if( maxdim < sizes[i] )
				scale= scales[i]
				break;
			endif
			i+=1
		while(i<nsizes)
		KillDataFolder :			// zap our two temp waves that were used as lookup tables
		if( scale == 0 )
			Abort "Image is bigger than planned for"
			return 0
		endif
		width *= scale;
		height *= scale;
	while(0)

	String axname= ImageInfo("",imagename,0)
	Variable p0= strsearch(axname, "YAXIS:", 0)
	p0=  strsearch(axname, ":", p0)
	p1=  strsearch(axname, ";", p0)
	if( flipVert != -1 )
		if( flipVert )
			SetAxis/A $(axname[p0+1,p1-1])
		else
			SetAxis/A/R $(axname[p0+1,p1-1])
		endif
	endif
	width *= 72/ScreenResolution					// make image pixels match screen pixels
	height *= 72/ScreenResolution					// make image pixels match screen pixels
	ModifyGraph width=width,height=height
	DoUpdate
	if( forceSize==0 )
		ModifyGraph width=0,height=0
	endif
end


Function SaveCombinedImage(Data1, Data2)
	string Data1, Data2

	string  SaveFileName
	variable refnum
	variable index
	variable data
	variable XNum, YNum
	variable Reserved=0


	NVAR  FileType=root:ViewVariables:FileType
	NVAR  FileHeaderSize=root:ViewVariables:FileHeaderSize
	NVAR  FrameHeaderSize=root:ViewVariables:FrameHeaderSize
	NVAR  TextEncoding=root:ViewVariables:TextEncoding
	NVAR  OpeNameSize=root:ViewVariables:OpeNameSize
	NVAR CommentSize=root:ViewVariables:CommentSize
	NVAR DataType1ch=root:ViewVariables:DataType1ch
	NVAR DataType2ch=root:ViewVariables:DataType2ch
	NVAR FrameNum=root:ViewVariables:FrameNum
	NVAR ImageNum=root:ViewVariables:ImageNum
	NVAR ScanDirection=root:ViewVariables:ScanDirection
	NVAR ScanTryNum=root:ViewVariables:ScanTryNum
	NVAR XPixel=root:ViewVariables:XPixel
	NVAR YPixel=root:ViewVariables:YPixel
	NVAR XScanSize=root:ViewVariables:XScanSize
	NVAR YScanSize=root:ViewVariables:YScanSize
	NVAR AveFlag=root:ViewVariables:AveFlag
	NVAR AverageNum=root:ViewVariables:AverageNum
	NVAR Year=root:ViewVariables:Year
	NVAR Month=root:ViewVariables:Month
	NVAR Day=root:ViewVariables:Day
	NVAR Hour=root:ViewVariables:Hour
	NVAR Minute=root:ViewVariables:Minute
	NVAR Second=root:ViewVariables:Second
	NVAR XRound=root:ViewVariables:XRound
	NVAR YRound=root:ViewVariables:YRound
	NVAR FrameTime=root:ViewVariables:FrameTime
	NVAR Sensitivity=root:ViewVariables:Sensitivity
	NVAR PhaseSens=root:ViewVariables:PhaseSens
	variable Offset
	NVAR MachineNo=root:ViewVariables:MachineNo
	NVAR ADRange=root:ViewVariables:ADRange
	NVAR ADResolution=root:ViewVariables:ADResolution
	NVAR MaxScanSizeX=root:ViewVariables:MaxScanSizeX
	NVAR MaxScanSizeY=root:ViewVariables:MaxScanSizeY
	NVAR PiezoConstX=root:ViewVariables:PiezoConstX
	NVAR PiezoConstY=root:ViewVariables:PiezoConstY
	NVAR PiezoConstZ=root:ViewVariables:PiezoConstZ
	NVAR DriverGainZ=root:ViewVariables:DriverGainZ
	NVAR MaxData=root:ViewVariables:MaxData
	NVAR MiniData=root:ViewVariables:MiniData
	SVAR OpeName=root:ViewVariables:OpeName


	NVAR ImageIndex=root:ViewVariables:ImageIndex
	NVAR ImageFileIndex=root:ViewVariables:ImageFileIndex
	Wave ImageListBuddy=root:ViewVariables:ImageListBuddy

	Wave DisplayImage=root:ViewVariables:DisplayImage

	variable FrameCount

	NVAR startframe=root:ViewVariables:FirstFrame
	NVAR endFrame=root:ViewVariables:LastFrame


	SVAR Comment=root:ViewVariables:Comment

	String TComment

	variable i,j

	variable ret

	variable size, CommentSizeForSave, FileHeaderSizeForSave

	variable AllFrameNum=0



	//Open/Z/D/P=ViewPath/T="????"/M="Select Folder" refnum as SaveFileName

	String FileNameSerach

	Wave/T ImageList=root:ViewVariables:ImageList

	Wave/T FolderList=root:ViewVariables:FolderList

	for(i=1; i<=2; i+=1)

		ImageIndex=0

		if(i==1)
			FileNameSerach=Data1+".asd"
		else
			FileNameSerach=Data2+".asd"
		endif

		ImageListBuddy[ImageFileIndex]=0

		FindValue/TXOP=4/TEXT=FileNameSerach ImageList

		ImageFileIndex=V_Value

		ImageListBuddy[ImageFileIndex]=1


		ImageFileOpen()

		AllFrameNum +=FrameNum
	endfor

	SaveFileName=Data1+"_"+Data2+"_Comb"+".asd"


	Open/Z/D/P=ViewPath/T="????"/M="Select Folder" refnum as SaveFileName


	//Open/Z/D/P=ViewPath/T="????"/M="Select Folder" refnum as SaveFileName
	strswitch(S_FileName)
		case "":
			return 0
	endswitch

	SaveFileName=S_FileName
	Open refnum as SaveFileName

	FrameCount=0

	for(i=1; i<=2; i+=1)

		ImageIndex=0

		if(i==1)
			FileNameSerach=Data1+".asd"
		else
			FileNameSerach=Data2+".asd"
		endif

		ImageListBuddy[ImageFileIndex]=0

		FindValue/TXOP=4/TEXT=FileNameSerach ImageList

		ImageFileIndex=V_Value

		ImageListBuddy[ImageFileIndex]=1


		ImageFileOpen()


		for(index=0; index<=EndFrame;index+=1)




			ImageIndex=index

			ret=tu_DisplayIndexedImage()
			if(ret==1)
				DoAlert 1, "Error:td_DisplayIndexedImage"
				return 0
			endif

			ShowImage( 0)


			if(index==0 && i==1)

				size=FileHeaderSize-CommentSize

				CommentSizeForSave=strlen(Comment)

				FileHeaderSizeForSave=size+Commentsize

				FBinWrite/F=3 refnum, FileType
				FBinWrite/F=3 refnum, FileHeaderSizeForSave
				FBinWrite/F=3 refnum, FrameHeaderSize
				FBinWrite/F=3 refnum, TextEncoding
				FBinWrite/F=3 refnum, OpeNameSize
				FBinWrite/F=3 refnum, CommentSizeForSave
				FBinWrite/F=3 refnum, DataType1ch
				FBinWrite/F=3 refnum, DataType2ch
				FBinWrite/F=3 refnum, AllFrameNum
				FBinWrite/F=3 refnum, AllFrameNum
				FBinWrite/F=3 refnum, ScanDirection
				FBinWrite/F=3 refnum, ScanTryNum
				FBinWrite/F=3 refnum, XPixel
				FBinWrite/F=3 refnum, YPixel
				FBinWrite/F=3 refnum, XScanSize
				FBinWrite/F=3 refnum, YScanSize
				FBinWrite/F=1 refnum,AveFlag
				FBinWrite/F=3 refnum,AverageNum
				FBinWrite/F=3 refnum,Year
				FBinWrite/F=3 refnum,Month
				FBinWrite/F=3 refnum,Day
				FBinWrite/F=3 refnum,Hour
				FBinWrite/F=3 refnum,Minute
				FBinWrite/F=3 refnum,Second
				FBinWrite/F=3 refnum,XRound
				FBinWrite/F=3 refnum,YRound
				FBinWrite/F=4 refnum,FrameTime
				FBinWrite/F=4 refnum,Sensitivity
				FBinWrite/F=4 refnum,PhaseSens
				FBinWrite/F=3 refnum,Offset
				FBinWrite/F=3 refnum,Offset
				FBinWrite/F=3 refnum,Offset
				FBinWrite/F=3 refnum,Offset

				FBinWrite/F=3 refnum,MachineNo
				FBinWrite/F=3 refnum,ADRange
				FBinWrite/F=3 refnum,ADResolution
				FBinWrite/F=4 refnum,MaxScanSizeX
				FBinWrite/F=4 refnum,MaxScanSizeY
				FBinWrite/F=4 refnum,PiezoConstX
				FBinWrite/F=4 refnum,PiezoConstY
				FBinWrite/F=4 refnum,PiezoConstZ
				FBinWrite/F=4 refnum,DriverGainZ

				FBinWrite refnum,OpeName

				FBinWrite refnum,Comment

			endif //index���[���̂Ƃ������t�@�C���w�b�_�̏�������
			//Frame



			WaveStats/Q/Z DisplayImage
			MaxData=V_Max
			MiniData=V_Min


			FSetPos refnum, FileHeaderSizeForSave+(FrameHeaderSize+2*Xpixel*YPixel)*FrameCount

			FBinWrite/F=3/U refNum, FrameCount
			FBinWrite/F=2/U refNum, MaxData
			FBinWrite/F=2/U refNum, MiniData
			FBinWrite/F=2 refNum, XOffset
			FBinWrite/F=2 refNum, YOffset
			FBinWrite/F=4 refNum,  XTilt
			FBinWrite/F=4 refNum, YTilt
			FBinWrite/F=1 refNum, LaserFlag
			FBinWrite/F=1 refNum, Reserved
			FBinWrite/F=2 refNum, Reserved
			FBinWrite/F=3 refNum, Reserved
			FBinWrite/F=3 refNum, Reserved

			for(Ynum=0; Ynum<YPixel; Ynum+=1)
				for(Xnum=0; Xnum<Xpixel;Xnum+=1)

					data=(5.0-DisplayImage[Xnum][Ynum]/PiezoConstZ/DriverGainZ)*4096.0/10.0

					//data= DisplayImage[Xnum][Ynum]
					//data=DisplayImage[Xnum][Ynum]*1e+9
					FBinWrite/F=2 refNum, data
					//DisplayImage[Xnum][Ynum]=5-data*10/4096*PiezoConstZ*DriverGainZ

				Endfor


			Endfor

			FrameCount +=1

		Endfor

	endfor
	Close refnum


End


Function ShowColorBar()

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables

	Wave ColorBar

	If(WaveExists(ColorBar)==0)

		Make/O/N=(2,100) ColorBar

		//      variable i, j
		//
		//      for(i=0;i<10;i+=1)
		//       for(j=0;j<256;j+=1)
		//
		//       ColorBar[i][j]=j/255
		//
		//      endfor
		//
		//      endfor

	endif

	variable i, j
	Wave MyColors
	Wave DisplayImage
     	variable zmax, zmin

	NVAR CheckShowCBar
	DoWindow Image1ch
	if(v_flag==0)

		CheckShowCBar=0

		return 0
	endif

	NVAR checkfloat=root:Packages:WMImProcess:ImageRange:checkfloat

	NVAR ScaleMode=root:ViewVariables:ScaleMode

 //     if(ScaleMode==0)



	WaveStats/Q DisplayImage

	zmax=v_max
	zmin=v_min

	NVAR  ScaleMode


	for(i=0;i<2;i+=1)

		for(j=0;j<100;j+=1)

			ColorBar[i][j]=zmin+(zmax-zmin)*j/99

		endfor

	endfor



     SetScale/I y 0, zmax-zmin,"nm", ColorBar



	DoWIndow ColorBarPanel

	if(v_flag ==1)
	 return 0
   elseif(v_flag==0)

		NewImage/K=2/S=2/F/N=ColorBar  ColorBar
		DoWindow/C ColorBarPanel

		GetWindow Image1ch, wsize
		MoveWIndow/W=ColorBarPanel V_right,V_top,v_right+80,v_top+(abs(v_top-v_bottom))


		ModifyGraph/W=ColorBarPanel tick(bottom)=3,mirror(bottom)=1, minor(left)=0
		ModifyGraph/W=ColorBarPanel noLabel(bottom)=2, tkLblRot=0, tlOffset(left)=0
		ModifyGraph/W=ColorBarPanel  fStyle(left)=1,fSize(left)=12,font(left)="Arial"

	endif

	if(ScaleMode==1)


		NVAR nzmax= root:Packages:WMImProcess:ImageRange:zmax
		NVAR nzmin= root:Packages:WMImProcess:ImageRange:zmin


		if(checkfloat ==1)

		  SetScale/I y 0, nzmax-nzmin,"nm", ColorBar


		for(i=0;i<2;i+=1)

		for(j=0;j<100;j+=1)

			ColorBar[i][j]=nzmin+(nzmax-nzmin)*j/99

		endfor

	endfor


		endif


	endif



	ModifyImage/W=ColorBarPanel ColorBar, cindex=MyColors

	//////////

	SetDataFolder SavedDataFolder
End

Function MakeColorPanel()

	string SavedDataFolder = GetDataFolder(1)


	DoWindow ColorAdjustGraph

	if(v_flag==1)
		return 0
	endif

	Variable x0=104*72/ScreenResolution, y0= 56*72/ScreenResolution
	Variable x1=550*72/ScreenResolution, y1= 346*72/ScreenResolution

	Wave myColors=root:ViewVariables:myColors

	Wave DIWave=root:ViewVariables:Colors:DIColors

	if(DataFolderExists("root:ViewVariables:Colors")==0)

		NewDataFolder/S root:ViewVariables:Colors

		variable/G WhichColor=1
		String/G ColorName=""
		String/G ColorList //="DI;Gray"
		String/G ColorLUT
		ColorLUT="Rainbow;YellowHot;BlueHot;RedWhiteBlue;PlanetEarth;Terrain;Cyan;Magenta;Yellow;Copper;Gold;CyanMagenta;RedWhiteGreen;BlueBlackRed;Geo;LandAndSea;BlackBody;Spectrum;Cycles;Fiddle;Pastels;BrownViolet;ColdWarm;Mocha;SeaLandAndFire;Mud;Classification"

		variable/G ColotLUTNum=1
		//  MakeDefaultColor2D()

		Make/O/N=2 RWave
		Make/O/N=2 GWave
		Make/O/N=2 BWave

		Make/O/N=2 RXWave
		Make/O/N=2 GXWave
		Make/O/N=2 BXWave
		Make/O/N=100 RWave65535
		Make/O/N=100 GWave65535
		Make/O/N=100 BWave65535


	else

		SetDataFolder root:ViewVariables:Colors
	endif

	/////

	//File Open
	LoadData/Q/P=FalconViewerPath/O "ColorTables.pxp" //Load PanelParams Waves


	/////////

	Display/K=1 /W=(x0,y0,x1,y1) RWave vs RXWave as "Color Change"
	DoWindow/C ColorAdjustGraph

	//ModifyGraph/W=ColorAdjustGraph tick(left)=3,noLabel(left)=2
	ModifyGraph/W=ColorAdjustGraph tick(Bottom)=3,noLabel(Bottom)=2,live=1

	AppendtoGraph/W=ColorAdjustGraph  GWave vs GXWave
	AppendtoGraph/W=ColorAdjustGraph  BWave vs BXWave

	ModifyGraph rgb(BWave)=(0,0,65535),live=1
	ModifyGraph rgb(GWave)=(0,65535,0),live=1

	NVAR WhichColor
	SVAR ColorList
	String quote = "\""

	String List=quote+ColorList+quote
	ControlBar/W=ColorAdjustGraph 55
	PopupMenu PopWhichColor,win=ColorAdjustGraph, pos={6,6},size={160,24},proc=WhichColorPopMenuProc,title="Color:"
	PopupMenu PopWhichColor,win=ColorAdjustGraph, mode=WhichColor,value= #List

	Button LockColorButton,win=ColorAdjustGraph,pos={150,6} ,size={50,20}, proc=ColorLockButtonProc,title="Lock"

	Button SaveColorButton,win=ColorAdjustGraph,pos={220,6},size={50,20},proc=ColorSaveButtonProc,title="Save"


	SVAR ColorLUT
	NVAR ColotLUTNum


	// ListLUT=StringFromList(ColorLUT,0)
	List=quote+ColorLUT+quote
	PopupMenu PopColorLUT,win=ColorAdjustGraph, pos={6,30},size={160,24},proc=ColorLUTPopMenuProc,title="Built-in Colors:"
	PopupMenu PopColorLUT,win=ColorAdjustGraph, mode=ColotLUTNum,value= #List



	SVAR ColorName=root:ViewVariables:Colors:ColorName

	ColorName=""
	SetVariable setvarColorName,win=ColorAdjustGraph, pos={290,7},size={150,15},title="Color Name"
	SetVariable setvarColorName,win=ColorAdjustGraph, value=root:ViewVariables:Colors:ColorName

	string Color

	Color=StringFromList(WhichColor-1, ColorList)

	//WhichColorPopMenuProc("",WhichColor ,Color)
	NVAR CheckShowCBar=root:ViewVariables:CheckShowCBar
	CheckShowCBar =1
	ShowColorBar()

	DoWIndow ColorBarPanel
	if(v_flag==1)
		AutoPositionWindow/E/M=0/R=ColorBarPanel ColorAdjustGraph//            $"Image1ch"
	else
		AutoPositionWindow/E/M=0/R=Image1ch  ColorAdjustGraph//

	endif
	//AutoPositionWindow/E/M=0/R=MainViewPanel  ColorAdjustGraph



	DoUpdate

	SetWindow ColorAdjustGraph hook=ColorWindowProcHook, hookevents=7
	ColorWindowProcHook("EVENT:active")

	GraphWaveEdit/W=ColorAdjustGraph /M/t=0

	SetDataFolder SavedDataFolder
end


Function ColorSaveButtonProc(ctrlName) : ButtonControl
	String ctrlName

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables:Colors

	SVAR ColorName
	strswitch(ColorName)
		case "":
			DoAlert/T="Alert"  0, "Name Color"
			return 0
	endswitch


	Wave RWave, BWave, GWave, RXWave, GXWave, BXWave

	variable size

	size=numpnts(RWave)

	if(size<numpnts(BWave))

		size=numpnts(BWave)
	endif
	if(size<numpnts(GWave))

		size=numpnts(GWave)
	endif

	SVAR ColorName

	Make/O/N=(size,3) $ColorName
	Make/O/N=(size,3) $ColorName+"_X"

	Wave ColorWave=$ColorName
	Wave ColorWaveX= $ColorName+"_X"
	variable i
	for(i=0;i<size;i+=1)

		if(i<numpnts(RWave))
			ColorWave[i][0]=RWave[i]
			ColorWaveX[i][0]=RXWave[i]
		else
			ColorWave[i][0]=NAN
			ColorWaveX[i][0]=NAN
		endif

		if(i<numpnts(GWave))
			ColorWave[i][1]=GWave[i]
			ColorWaveX[i][1]=GXWave[i]
		else
			ColorWave[i][1]=NAN
			ColorWaveX[i][1]=NAN
		endif

		if(i<numpnts(BWave))
			ColorWave[i][2]=BWave[i]
			ColorWaveX[i][2]=BXWave[i]
		else
			ColorWave[i][2]=NAN
			ColorWaveX[i][2]=NAN
		endif



	endfor


	SVAR ColorList
	string check=ListMatch(ColorList, ColorName, ";")
	variable alertcheck=0
	strswitch(check)
		case "":
			alertcheck=1
			break
	endswitch



	if( alertcheck==0)

		DoAlert/T="Alert"  1, "Already exists. Overwrite (Y/N)?"

	endif

	if(v_flag==2)

		return 0
	else


		ColorList= RemoveFromList( ColorName,ColorList)

	endif



	string tentative= ";"+ColorName
	ColorList += tentative

	String SaveObjects=""

	variable num=ItemsInList(ColorList)
	//	variable i
	String ColorWaveSave
	String ColorWaveSaveX

	ColorWaveSave=StringFromList(0, ColorList, ";")
	ColorWaveSaveX=ColorWaveSave+"_X"
	SaveObjects += ColorWaveSave

	tentative=";"+ ColorWaveSaveX
	SaveObjects += tentative

	for(i=1; i<num; i+=1)

		ColorWaveSave=StringFromList(i, ColorList, ";")
		tentative=";"+ ColorWaveSave
		SaveObjects += tentative

		ColorWaveSaveX=ColorWaveSave+"_X"
		tentative=";"+ ColorWaveSaveX
		SaveObjects += tentative

	endfor

	SaveObjects +=";ColorList"

	SaveData/Q/P=FalconViewerPath/O/J=SaveObjects "ColorTables.pxp"


	NVAR WhichColor
	SVAR ColorList

	WhichColor=ItemsInList(ColorList)
	String quote = "\""

	String List=quote+ColorList+quote

	PopupMenu PopWhichColor,win=ColorAdjustGraph, mode=WhichColor,value= #List

	SetDatafolder SavedDataFolder

End

Function ColorLockButtonProc(ctrlName) : ButtonControl
	String ctrlName

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables:Colors


	ShowTools/W=ColorAdjustGraph
	HideTools/W=ColorAdjustGraph


	Button LockColorButton,win=ColorAdjustGraph, Rename=UnLockColorButton,proc=ColorUnLockButtonProc,title="Unlock"


	SetDatafolder SavedDataFolder

End

Function ColorUnLockButtonProc(ctrlName) : ButtonControl
	String ctrlName

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables:Colors


	GraphWaveEdit/W=ColorAdjustGraph /M/t=0

	Button UnLockColorButton,win=ColorAdjustGraph, Rename=LockColorButton,proc=ColorLockButtonProc,title="Lock"


	SetDatafolder SavedDataFolder

End


Function ColorWindowProcHook(infoStr)
	String infoStr

	String event= StringByKey("EVENT",infoStr)


	if( StrSearch(infoStr,"EVENT:activate",0) >=0 )
		ColorUpDate()
		return 1
	endif

	if( StrSearch(infoStr,"EVENT:mouseup",0) >=0 )
		ColorUpDate()
		return 1
	endif

	if( StrSearch(infoStr,"EVENT:deactivate",0) >=0 )
		ColorUpDate()
		return 1
	endif

	return 0
end

Function ColorLUTPopMenuProc(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr


	SetWindow ColorAdjustGraph hook=$""

	ShowTools/W=ColorAdjustGraph
	HideTools/W=ColorAdjustGraph

	ControlInfo UnLockColorButton
	if(v_flag==1)
		Button UnLockColorButton,win=ColorAdjustGraph, disable=2
	endif

	ControlInfo  LockColorButton
	if(v_flag==1)
		Button LockColorButton,win=ColorAdjustGraph, disable=2
	endif

	ControlInfo  SaveColorButton
	if(v_flag==1)
		Button SaveColorButton,win=ColorAdjustGraph, disable=2
	endif



	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables:Colors

	SVAR ColorLUT

	String ColorName=StringFromList(popNum-1, ColorLUT)

	ColorTab2Wave $ColorName

	Wave m_colors

	SetDataFolder root:ViewVariables

	Duplicate/O M_colors myColors


	ShowImage(0)



	SetDataFolder SavedDataFolder
End


Function WhichColorPopMenuProc(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr


	string SavedDataFolder = GetDataFolder(1)

	SetWindow ColorAdjustGraph hook=ColorWindowProcHook, hookevents=7
	ColorWindowProcHook("EVENT:active")

	GraphWaveEdit/W=ColorAdjustGraph /M/t=0

	ControlInfo UnLockColorButton
	if(v_flag==1)
		Button UnLockColorButton,win=ColorAdjustGraph, disable=0
	endif

	ControlInfo  LockColorButton
	if(v_flag==1)
		Button LockColorButton,win=ColorAdjustGraph, disable=0
	endif

	ControlInfo  SaveColorButton
	if(v_flag==1)
		Button SaveColorButton,win=ColorAdjustGraph, disable=0
	endif



	SetDataFolder root:ViewVariables:Colors

	NVAR WhichColor=root:ViewVariables:Colors:WhichColor

	WhichColor=popNum

	//if(WhichColor==1)

	Wave ColorWave=$popStr //DI, DI_X

	Duplicate/O  ColorWave, CDummy
	DeletePoints/M=1 1,2, CDummy
	Duplicate/O CDummy, RWave

	Duplicate/O  ColorWave,C CDummy
	DeletePoints/M=1 0,1, CDummy
	DeletePoints/M=1 1,1, CDummy
	Duplicate/O CDummy, GWave

	Duplicate/O  ColorWave, CDummy
	DeletePoints/M=1 0,2, CDummy
	Duplicate/O CDummy, BWave

	Wave ColorWave_X= $popStr+"_X"
	Duplicate/O  ColorWave_X, CDummy
	DeletePoints/M=1 1,2,CDummy
	Duplicate/O CDummy, RXWave

	Duplicate/O  ColorWave_X, CDummy
	DeletePoints/M=1 0,1, CDummy
	DeletePoints/M=1 1,1, CDummy
	Duplicate/O CDummy, GXWave

	Duplicate/O  ColorWave_X, CDummy
	DeletePoints/M=1 0,2,CDummy
	Duplicate/O CDummy, BXWave


	//	elseif(WhichColor==2)
	//	Wave Gray
	//
	//	Duplicate/O  Gray, Dummy
	//	DeletePoints/M=1 1,2, Dummy
	//	Duplicate/O Dummy, RWave
	//	Duplicate/O Dummy, GWave
	//	Duplicate/O Dummy, BWave
	//	Duplicate/O Dummy, RXWave
	//	Duplicate/O Dummy, GXWave
	//	Duplicate/O Dummy, BXWave
	//
	//
	//	endif

	KillWaves CDummy


	ColorUpDate()

	SetDataFolder SavedDataFolder
End

Function ColorUpDate()

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables:
	Make/O/N=(100,3)  myColors


	SetDataFolder root:ViewVariables:Colors

	Wave myColors=root:ViewVariables:myColors

	Wave RWave=root:ViewVariables:Colors:RWave
	Wave GWave=root:ViewVariables:Colors:GWave
	Wave BWave=root:ViewVariables:Colors:BWave
	Wave RXWave=root:ViewVariables:Colors:RXWave
	Wave GXWave=root:ViewVariables:Colors:GXWave
	Wave BXWave=root:ViewVariables:Colors:BXWave

	Wave RWave65535=root:ViewVariables:Colors:RWave65535
	Wave GWave65535=root:ViewVariables:Colors:GWave65535
	Wave BWave65535=root:ViewVariables:Colors:BWave65535

	//Duplicate/O RDummy RWave


	NVAR WhichColor=root:ViewVariables:Colors:WhichColor
	variable maxval

	RWave65535[]=interp(p/100, RXWave, RWave)
	maxval=WaveMax(RWave65535)
	//RWave65535 /=maxval

	GWave65535[]=interp(p/100, GXWave, GWave)
	maxval=WaveMax(GWave65535)
	//GWave65535 /=maxval;


	BWave65535[]=interp(p/100, BXWave, BWave) //RWave(i)
	maxval=WaveMax(BWave65535)
	//BWave65535 /=maxVal



	myColors[][0]=RWave65535[p]*65535
	myColors[][1]=GWave65535[p]*65535
	myColors[][2]=BWave65535[p]*65535

	ShowImage(0)

	//NVAR CheckShowCBar=root:ViewVariables:CheckShowCBar
	//CheckShowCBar =1
	//ShowColorBar()

	SetDataFolder SavedDataFolder

End

Function ResetColorTable()


	DoWindow ColorAdjustGraph
	if(v_flag==1)
		KillWindow ColorAdjustGraph
	endif

	KillDataFolder/Z root:ViewVariables:Colors


	string SavedDataFolder = GetDataFolder(1)


	//SetDataFolder  root:ViewVariables

	// Make/O/N=(100,3) myColors
	// Make/O/N=(100,3) myColors2ch



	NewDataFolder/S root:ViewVariables:Colors

	variable/G WhichColor=1
	String/G ColorName=""
	String/G ColorList ="DI;Gray"
	String/G ColorLUT
	ColorLUT="Rainbow;YellowHot;BlueHot;RedWhiteBlue;PlanetEarth;Terrain;Cyan;Magenta;Yellow;Copper;Gold;CyanMagenta;RedWhiteGreen;BlueBlackRed;Geo;LandAndSea;BlackBody;Spectrum;Cycles;Fiddle;Pastels;BrownViolet;ColdWarm;Mocha;SeaLandAndFire;Mud;Classification"

	//  MakeDefaultColor2D()

	Make/O/N=2 RWave
	Make/O/N=2 GWave
	Make/O/N=2 BWave

	Make/O/N=2 RXWave
	Make/O/N=2 GXWave
	Make/O/N=2 BXWave
	Make/O/N=100 RWave65535
	Make/O/N=100 GWave65535
	Make/O/N=100 BWave65535

	//   Make/O/N=100 RWave65535
	// Make/O/N=100 GWave65535
	// Make/O/N=100 BWave65535



	Make/O/N=(3,3) DI
	Make/O/N=(3,3) DI_X


	DI[0][0]=0
	DI[1][0]=1
	DI[2][0]=1
	DI_X[0][0]=0
	DI_X[1][0]=160/255
	DI_X[2][0]=1

	DI[0][1]=0
	DI[1][1]=0.5
	DI[2][1]=1
	DI_X[0][1]=0
	DI_X[1][1]=0.5
	DI_X[2][1]=1

	DI[0][2]=0
	DI[1][2]=0
	DI[2][2]=1
	DI_X[0][2]=0
	DI_X[1][2]=45344/65535
	DI_X[2][2]=1

	Make/O/N=(2, 3) Gray
	Make/O/N=(2 ,3)Gray_X

	Gray[0][0]=0
	Gray[1][0]=1
	Gray[0][1]=0
	Gray[1][1]=1
	Gray[0][2]=0
	Gray[1][2]=1
	Gray_X[0][0]=0
	Gray_X[1][0]=1
	Gray_X[0][1]=0
	Gray_X[1][1]=1
	Gray_X[0][2]=0
	Gray_X[1][2]=1



	String SaveObjects="DI;DI_X;Gray;Gray_X;ColorList"
	SaveData/Q/P=FalconViewerPath/O/J=SaveObjects "ColorTables.pxp"


	//SetDataFolder  root:ViewVariables


	SetDataFolder SavedDataFolder
End

Function ColorExtract(ColorLUT)
	string ColorLUT

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables:Colors

	Wave RWave65535
	Wave GWave65535
	Wave BWave65535


	ColorTab2Wave $ColorLUT

	Wave m_colors

	SetDataFolder root:ViewVariables

	Duplicate/O M_colors myColors

	ShowImage(0)

	SetDataFolder SavedDataFolder

End


Function  MakeInterpolationPanel()

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:Viewvariables

	//SetDataFolder root

	DoWIndow Image1ch

	if(V_flag==0)

		doAlert 0, "Show the first image"
		return 0
	endif

	DoWIndow/F InterpolationPanel

	if(V_flag==1)
		return 0
	endif


	Wave InterpolationPanelParams=root:InterpolationP

	PauseUpdate; Silent 1		// building window...
	NewPanel /k=1/W=(1250,50,1670,285) as "Image Interpolation Panel"
	DoWindow/C/T InterpolationPanel "Image Interpolation Panel"

	//MoveWIndow TrackingPanel  350, 50, 350+
	MoveWindow/W=InterpolationPanel InterpolationPanelParams[0], InterpolationPanelParams[1], InterpolationPanelParams[2], InterpolationPanelParams[3]

	SetWIndow InterpolationPanel, hook=KillInterpolationPanel

	variable/G InterPMethod = 1
	PopupMenu popupInterPMethod,win=InterpolationPanel, mode=1,title="Method",pos={35,20},popvalue="Bilinear",value= #"\"Bilinear;Spline\"",proc=PopInterPMethodProc


	variable/G SamplingCoef=3

	SetVariable setvarSamplingCoef,win=InterpolationPanel, pos={35,60},size={155,14}, limits={0.5,10,0.5}, value= $"root:ViewVariables:SamplingCoef", title="Sampling Coefficient"


//	variable/G ResamplingFunc = 1
//	PopupMenu popupResamplingFunc,win=InterpolationPanel, mode=1,title="Function",pos={35,100},popvalue="Bilinear",value= #"\"nm;bilinear;cubic;spline;sinc\"",proc=PopResampleFucProc, disable =1

       variable/G SplineDeg =3
	SetVariable setvarSplineDeg, win=InterpolationPanel, pos={35,100},size={100,14}, limits={2,5,1}, value= $"root:ViewVariables:SplineDeg", title="Spline Degree", disable =0

	//variable/G InterOrder
	//SetVariable setvarInterporOrder, win=ImageShiftPanel, pos={200,130},size={60,14}, limits={2,4,1}, value= $"root:Analysis:ImageShift:InterOrder", title="Order"





	Button ButtonInterpolation,win=InterpolationPanel,pos={80,150},size={101,47},title="Do it", proc=ButtonInterporationProc



	SetDataFolder SavedDataFolder


End


Function ButtonInterporationProc(ctrlName) : ButtonControl
	String ctrlName

	string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables

	Wave DisplayImage

	NVAR  FileType=root:ViewVariables:FileType
	NVAR  FileHeaderSize=root:ViewVariables:FileHeaderSize
	NVAR  FrameHeaderSize=root:ViewVariables:FrameHeaderSize
	NVAR  TextEncoding=root:ViewVariables:TextEncoding
	NVAR  OpeNameSize=root:ViewVariables:OpeNameSize
	NVAR CommentSize=root:ViewVariables:CommentSize
	NVAR DataType1ch=root:ViewVariables:DataType1ch
	NVAR DataType2ch=root:ViewVariables:DataType2ch
	NVAR FrameNum=root:ViewVariables:FrameNum
	NVAR ImageNum=root:ViewVariables:ImageNum
	NVAR ScanDirection=root:ViewVariables:ScanDirection
	NVAR ScanTryNum=root:ViewVariables:ScanTryNum
	NVAR XPixel=root:ViewVariables:XPixel
	NVAR YPixel=root:ViewVariables:YPixel
	NVAR XScanSize=root:ViewVariables:XScanSize
	NVAR YScanSize=root:ViewVariables:YScanSize
	NVAR AveFlag=root:ViewVariables:AveFlag
	NVAR AverageNum=root:ViewVariables:AverageNum
	NVAR Year=root:ViewVariables:Year
	NVAR Month=root:ViewVariables:Month
	NVAR Day=root:ViewVariables:Day
	NVAR Hour=root:ViewVariables:Hour
	NVAR Minute=root:ViewVariables:Minute
	NVAR Second=root:ViewVariables:Second
	NVAR XRound=root:ViewVariables:XRound
	NVAR YRound=root:ViewVariables:YRound
	NVAR FrameTime=root:ViewVariables:FrameTime
	NVAR Sensitivity=root:ViewVariables:Sensitivity
	NVAR PhaseSens=root:ViewVariables:PhaseSens
	variable Offset
	NVAR MachineNo=root:ViewVariables:MachineNo
	NVAR ADRange=root:ViewVariables:ADRange
	NVAR ADResolution=root:ViewVariables:ADResolution
	NVAR MaxScanSizeX=root:ViewVariables:MaxScanSizeX
	NVAR MaxScanSizeY=root:ViewVariables:MaxScanSizeY
	NVAR PiezoConstX=root:ViewVariables:PiezoConstX
	NVAR PiezoConstY=root:ViewVariables:PiezoConstY
	NVAR PiezoConstZ=root:ViewVariables:PiezoConstZ
	NVAR DriverGainZ=root:ViewVariables:DriverGainZ
	NVAR MaxData=root:ViewVariables:MaxData
	NVAR MiniData=root:ViewVariables:MiniData
	SVAR OpeName=root:ViewVariables:OpeName

	NVAR ImageIndex=root:ViewVariables:ImageIndex
	NVAR LaserFlag=root:ViewVariables:LaserFlag
	SVAR FileName=root:ViewVariables:FileName

	NVAR CurrentNum=root:ViewVariables:CurrentNum
	NVAR XOffset=root:ViewVariables:XOffset
	NVAR YOffset=root:ViewVariables:YOffset
	NVAR XTilt=root:ViewVariables:XTilt
	NVAR YTilt=root:ViewVariables:YTilt

	NVAR Show2chFlag=root:ViewVariables:Show2chFlag

	NVAR CheckSwapChFlag=root:ViewVariables:CheckSwapChFlag

	NVAR InterPMethod = root:ViewVariables:InterPMethod
	NVAR SamplingCoef = root:ViewVariables:SamplingCoef
	NVAR ResamplingFunc = root:ViewVariables:ResamplingFunc
	NVAR SplineDeg = root:ViewVariables:SplineDeg

	Wave DisplayImage=root:ViewVariables:DisplayImage
	Wave DisplayImage2ch=root:ViewVariables:DisplayImage2ch
	//   NVAR startFrame=root:ViewVariables:FirstFrame
	//      NVAR endFrame=root:ViewVariables:LastFrame

	NVAR upSample

	SVAR Comment=root:ViewVariables:Comment


	variable size, CommentSizeForSave, FileHeaderSizeForSave

	string  SaveFileName
	variable refnum, frame
	variable index
	variable data
	variable XNum, YNum
	variable Reserved=0


	size=FileHeaderSize-CommentSize


	//sprintf Comment, S_Selection
	//	Comment=S_Selection


	Comment +="\r## Resampling ## : "+date()

	CommentSizeForSave=strlen(Comment)

	FileHeaderSizeForSave=size+CommentSizeForSave

	SaveFileName=FileNameOnly(FileName)+"_RS"+".asd"

	Open/Z/D/P=ViewPath/T="????"/M="Select Folder" refnum as SaveFileName

	strswitch(S_FileName)
		case "":
			return 0
	endswitch

	SaveFileName=S_FileName


	//SaveFileName=FileNameOnly(FileName)+"_RS.asd"

	variable RS_X, RS_Y

	if(DataType2ch  == 0)

		Open refnum as SaveFileName

		for(frame=0;frame<FrameNum;frame+=1)
			ImageIndex =frame

			tu_DisplayIndexedImage()


			if(CheckSwapChFlag==1)

				Duplicate/O DisplayImage TempSwapImage

				Duplicate/O DisplayImage2ch DisplayImage

				Duplicate/O TempSwapImage DisplayImage2ch

				KIllWaves TempSwapImage

			endif


			//if(DataType2ch ==0 || Show2chFlag==0)
			ShowImage(0)

			DoUpDate



			//Duplicate/O DisplayImage,DisplayImage_samp;DelayUpdate
			//NVAR InterPMethod = root:ViewVariables:InterPMethod
			//NVAR SamplingCoef = root:ViewVariables:SamplingCoef
			//NVAR ResamplingFunc = root:ViewVariables:ResamplingFunc
			//NVAR SplineDeg = root:ViewVariables:SplineDeg



			if(InterPMethod ==1)

			       ImageInterpolate/F={(SamplingCoef*XPixel-1)/(XPixel-1), (SamplingCoef*YPixel-1)/(YPixel-1)}/DEST=InterPImage Bilinear DisplayImage

			elseif(InterPMethod ==2)

				 ImageInterpolate/F={(SamplingCoef*XPixel-1)/(XPixel-1), (SamplingCoef*YPixel-1)/(YPixel-1)}/DEST=InterPImage/D=(SplineDeg)  Spline DisplayImage

//		      elseif(InterPMethod ==3)
//
//				 ImageInterpolate/FUNC=nn/F={(SamplingCoef*XPixel-1)/(XPixel-1), (SamplingCoef*YPixel-1)/(YPixel-1)}/DEST=InterPImage  Resample DisplayImage
		      endif




			if(frame==0)

				RS_X=Dimsize(InterPImage,0)
				RS_Y=Dimsize(InterPImage,1)


				FBinWrite/F=3 refnum, FileType
				FBinWrite/F=3 refnum, FileHeaderSizeForSave
				FBinWrite/F=3 refnum, FrameHeaderSize
				FBinWrite/F=3 refnum, TextEncoding
				FBinWrite/F=3 refnum, OpeNameSize
				FBinWrite/F=3 refnum, CommentSizeForSave
				FBinWrite/F=3 refnum, DataType1ch
				FBinWrite/F=3 refnum, DataType2ch
				FBinWrite/F=3 refnum, FrameNum
				FBinWrite/F=3 refnum, ImageNum
				FBinWrite/F=3 refnum, ScanDirection
				FBinWrite/F=3 refnum, ScanTryNum
				FBinWrite/F=3 refnum, RS_X
				FBinWrite/F=3 refnum, RS_Y
				FBinWrite/F=3 refnum, XScanSize
				FBinWrite/F=3 refnum, YScanSize
				FBinWrite/F=1 refnum,AveFlag
				FBinWrite/F=3 refnum,AverageNum
				FBinWrite/F=3 refnum,Year
				FBinWrite/F=3 refnum,Month
				FBinWrite/F=3 refnum,Day
				FBinWrite/F=3 refnum,Hour
				FBinWrite/F=3 refnum,Minute
				FBinWrite/F=3 refnum,Second
				FBinWrite/F=3 refnum,XRound
				FBinWrite/F=3 refnum,YRound
				FBinWrite/F=4 refnum,FrameTime
				FBinWrite/F=4 refnum,Sensitivity
				FBinWrite/F=4 refnum,PhaseSens
				FBinWrite/F=3 refnum,Offset
				FBinWrite/F=3 refnum,Offset
				FBinWrite/F=3 refnum,Offset
				FBinWrite/F=3 refnum,Offset

				FBinWrite/F=3 refnum,MachineNo
				FBinWrite/F=3 refnum,ADRange
				FBinWrite/F=3 refnum,ADResolution
				FBinWrite/F=4 refnum,MaxScanSizeX
				FBinWrite/F=4 refnum,MaxScanSizeY
				FBinWrite/F=4 refnum,PiezoConstX
				FBinWrite/F=4 refnum,PiezoConstY
				FBinWrite/F=4 refnum,PiezoConstZ
				FBinWrite/F=4 refnum,DriverGainZ

				FBinWrite refnum,OpeName

				FBinWrite refnum,Comment

			endif //index���[���̂Ƃ������t�@�C���w�b�_�̏�������
			//Frame


			SetScale x 0,XScanSize*1e-9,"m", InterPImage
			SetScale y 0,YScanSize*1e-9,"m", InterPImage


			WaveStats/Q/Z DisplayImage
			MaxData=V_Max
			MiniData=V_Min

			//tu_Resampling(DisplayImage)

			FSetPos refnum, FileHeaderSizeForSave+(FrameHeaderSize+2*RS_X*RS_Y)*frame
			CurrentNum=frame
			FBinWrite/F=3/U refNum, CurrentNum
			FBinWrite/F=2/U refNum, MaxData
			FBinWrite/F=2/U refNum, MiniData
			FBinWrite/F=2 refNum, XOffset
			FBinWrite/F=2 refNum, YOffset
			FBinWrite/F=4 refNum,  XTilt
			FBinWrite/F=4 refNum, YTilt
			FBinWrite/F=1 refNum, LaserFlag
			FBinWrite/F=1 refNum, Reserved
			FBinWrite/F=2 refNum, Reserved
			FBinWrite/F=3 refNum, Reserved
			FBinWrite/F=3 refNum, Reserved

			for(Ynum=0; Ynum<RS_Y; Ynum+=1)
				for(Xnum=0; Xnum<RS_X;Xnum+=1)

					data=(5.0-InterPImage[Xnum][Ynum]/PiezoConstZ/DriverGainZ)*4096.0/10.0
					FBinWrite/F=2 refNum, data
					//DisplayImage[Xnum][Ynum]=5-data*10/4096*PiezoConstZ*DriverGainZ

				Endfor
			Endfor

		endfor

		Close refnum


	Endif

	if(DataType2ch  !=0)

		return 0

	endif


	OpenFilesAgain(1)

	SetDataFolder SavedDataFolder




End



function KillInterpolationPanel(infoStr)		//kills the background task if the meter panel is closed and updates the position
	string infoStr

	string SavedDataFolder = GetDataFolder(1)

	if (stringmatch(infoStr,"*kill*"))

		SetDataFolder root:Viewvariables

		KillVariables/Z InterPMethod
		KillVariables/Z SamplingCoef
		KillVariables/Z SplineDeg

		KillWaves/Z InterPImage

		//

	endif

	SetDataFolder SavedDataFolder


End

Function OneDHist()


	Wave DisplayImage=root:ViewVariables:DisplayImage

	Make/O/N=(Dimsize(DisplayImage,0)) OneDImage

	variable x, y

	//for (y=0; y<Dimsize(DisplayImage,1) ;y+=1)

	for (x=0; x<Dimsize(DisplayImage,0) ;x+=1)

		OneDImage[x]=DisplayImage[x][6]


		//endfor
	endfor


End

Function ShowLaser()
string SavedDataFolder = GetDataFolder(1)

	SetDataFolder root:ViewVariables




	NVAR LaserFlag=root:ViewVariables:LaserFlag


	if(LAserFlag==0)
		SetDrawLayer/W=Image1ch/K USerFront
	else
		SetDrawLayer/W=Image1ch/K USerFront
		SetDrawLayer/W=Image1ch USerFront

		SetDrawEnv/W=Image1ch  xcoord=prel, ycoord=prel, fillfgc=(0,65280,0),  linethick= 0.00
		DrawRect/W=Image1ch 75/100, 85/100, 98/100,99/100
	endif
End

Function CSV_Converter()


	String ctrlName

	variable ret

	string presuffix

	String BaseName
	variable index


	variable refnum

	string SavedDataFolder = GetDataFolder(1)
	SetDataFolder root:ViewVariables


	NVAR SaveBMPFlag
	NVAR SaveJPEGFlag
	NVAR SaveTIFFFlag
	NVAR SaveBCRFlag
	NVAR SaveASDFlag
	NVAR SaveModeFlag
	NVAR SaveFlag

	SVAR FileName
	NVAR ImageIndex
	NVAR ImageNum
	NVAR FrameNum

	NVAR XPixel
	NVAR YPixel

	NVAR DataType2ch
	NVAR Show2chFlag

	SVAR SaveFilePath
	SVAR SaveFileName

	NVAR percentFinished

	SaveFlag=1

	String SaveFileName_Base

	NVAR  RecordedIndex

	variable SaveFloderFlag

	Wave DisplayImage
	Wave DisplayImage2ch

	//	DoAlert/T="Which folder do you want to save?" 1, "Original folder?"
	//
	//	if(v_flag==1)
	//
	//		SaveFloderFlag=0
	//	else
	//
	//		PathInfo PICPath
	//
	//		if(V_Flag==0)
	//
	//			DoAlert/T="Warning!" 0, "Set the folder"
	//
	//			return 0
	//
	//		else
	//
	//			SaveFloderFlag=1
	//
	//		endif
	//
	//	endif



	RecordedIndex=ImageIndex


	//if(SaveModeFlag==1 &&   (SaveBMPFlag==1 || SaveJPEGFlag==1 || SaveTIFFFlag==1 || SaveBCRFlag==1))  // Single File

	NVAR FrameNum

	BaseName=FileNameOnly(FileName)+".csv"


	Open/D/T="????"/M="Select Folder and Type BaseName" refnum as BaseName

	strswitch(S_FileName)
		case "":
			return 0
	endswitch

	SaveFilePath=RemoveFromList(StringFromList(ItemsInList(S_FileName, ":")-1, S_FileName, ":"), S_FileName, ":")

	NewPath/O/Q SaveImagePath, SaveFilePath

	BaseName=S_FileName

	DoWIndow/K Image1ch



	Wave DisplayImage

	NVAR XPixel, YPixel //, FrameNum

	variable TotalNum=XPixel*YPixel*FrameNum+3

	Make/O/N=3 OneDim_Data

	OneDim_Data[0]=XPixel
	OneDim_Data[1]=YPixel
	OneDim_Data[2]=FrameNum


	for(index=0;index<FrameNum;index+=1)
		ImageIndex=index


		if(index==0)
			DoWIndow ProgressBar
			if(V_flag==0)
				pnlProgress()
			endif
		endif

		if(index==FrameNum-1)
			DoWIndow/K/Z ProgressBar
		endif

		percentFinished=index*100/FrameNUm
		DoUpDate

		ret=tu_DisplayIndexedImage()
		if(ret==1)
			DoAlert 1, "Error: td_DisplayIndexedImage"
			return 0
		endif

		ShowImage(0)







		Duplicate/O DisplayImage OneD_Image

		WaveStats/Q OneD_Image

		OneD_Image -= v_avg


		Redimension/N=(XPixel*YPixel) OneD_Image

		Concatenate/O/NP {OneDim_Data, OneD_Image},  Dest_Wave

		Duplicate/O Dest_Wave, OneDim_Data


	Endfor

	SaveFileName=BaseName //+presuffix+num2str(ImageIndex)

	Save/J OneDim_Data as SaveFileName


	DoWIndow/K Image1ch


	ImageIndex=RecordedIndex

	ret=tu_DisplayIndexedImage()
	if(ret==1)
		DoAlert 1, "Error:td_DisplayIndexedImage"
		return 0
	endif


	ShowImage(0)

	DoWIndow/K/Z ProgressBar


	SetDataFolder SavedDataFolder

End

Function ShowMarkonForMovie(index)

	variable index

	SetDataFolder root:Analysis:


	Wave DisplayImage=root:ViewVariables:DisplayImage

	NVar ImageIndex=root:ViewVariables:ImageIndex


	Wave XYPosition1= root:Analysis:ImageTracking:XYPosition1
	Wave XYPosition2= root:Analysis:ImageTracking:XYPosition2



	if(index==0)

		RemoveFromGraph/Z/W=Image1ch MarkA_Y,MarkB_Y


		MAke/O/N=1 MarkA_X
		MAke/O/N=1 MarkA_Y

		MAke/O/N=1 MarkB_X
		MAke/O/N=1 MarkB_Y

		MarkA_X=XYPosition1[index][0]
		MarkA_Y=XYPosition1[index][1]


		MarkB_X=XYPosition2[index][0]
		MarkB_Y=XYPosition2[index][1]

		AppendToGraph /W=Image1ch MarkA_Y vs MarkA_X
		AppendToGraph /W=Image1ch MarkB_Y vs MarkB_X

		ModifyGraph/W=Image1ch mode(MarkA_Y)=3,marker(MarkA_Y)=19,msize(MarkA_Y)=5,mrkThick(MarkA_Y)=1;
		ModifyGraph /W=Image1ch rgb(MarkA_Y)=(65280,32768,58880)

		ModifyGraph/W=Image1ch mode(MarkB_Y)=3,marker(MarkB_Y)=19,msize(MarkB_Y)=5,mrkThick(MarkB_Y)=1;
		ModifyGraph /W=Image1ch rgb(MarkB_Y)=(16384,65280,65280)


	else

		MarkA_X= XYPosition1[index][0]
		MarkA_Y= XYPosition1[index][1]


		MarkB_X=XYPosition2[index][0]
		MarkB_Y=XYPosition2[index][1]


	endif


	//  MarkX[1]=SmallPX[ImageIndex] *dimdelta(DisplayImage,0)
	//  MarkY[1]=SmallPY[ImageIndex] *dimdelta(DisplayImage,1)

	//    MarkX[0]=CenterX[0]
	//    MarkY[0]= CenterY[0]


	// ModifyGraph mrkThick(MarkY)=1,mrkThick(CenterY)=2

	//   CenterX[0]=xcsr(A)
	//  CenterY[0]=vcsr(A)


End
