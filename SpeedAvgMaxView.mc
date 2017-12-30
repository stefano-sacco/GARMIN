using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class SpeedAvgMaxView extends Ui.DataField {

    var mSpeedValue		=	0	;
	var mAvgSpeedValue	=	0	;
	var mMaxSpeedValue	=	0	;	
	
	var mLabelX			=	0	;
	var mLabelY			=	0	;		        
	var mSpeedValX		=	0	;
	var mSpeedValY		=	0	;	
	var mAvgSpeedValX	=	0	;
	var mAvgSpeedValY	=	0	;
	var mMaxSpeedValX	=	0	;
	var mMaxSpeedValY	=	0	;
	
	
	private var 
		screenCenterX	= 0,
		screenCenterY	= 0,
		posx        	= 0,
		posy        	= 0;
	
	
	private var title   = "",
				status  = "",
				model = "???";
					
    function initialize() {
        DataField.initialize()		;		        
    }


    // Set your layout here. Anytime the size of obscurity of
    // the draw context is changed this will be called.
    function onLayout(dc) {
        // Use the generic, centered layout 
        
        screenCenterY = (dc.getHeight() /2);
        screenCenterX = (dc.getWidth() /2 );    
        //System.println(screenCenterH);
        //System.println(screenCenterV);        
    	model = Ui.loadResource(Rez.Strings.DeviceModel);        
          
		switch (model) {
			case "default":
				//mLabelX			=	screenCenterX			;
				//mLabelY			=	2						;  
				mSpeedValX		=	screenCenterX	-	25	;
				mSpeedValY		=	screenCenterY	-	0	;
				mAvgSpeedValX	=	screenCenterX	+	36	;
				mAvgSpeedValY	=	screenCenterY	-	32	;
				mMaxSpeedValX	=	screenCenterX	+	36	;
				mMaxSpeedValY	=	screenCenterY	+	0	;  		
				break;	
					
			case "edge820":
				//mLabelX			=	screenCenterX			;
				//mLabelY			=	2						;
				mSpeedValX		=	screenCenterX	-	18	;
				mSpeedValY		=	screenCenterY	+	0	;
				mAvgSpeedValX	=	screenCenterX	+	30	;
				mAvgSpeedValY	=	screenCenterY	-	22	;
				mMaxSpeedValX	=	screenCenterX	+	30	;
				mMaxSpeedValY	=	screenCenterY	+	0	;  		
				break;

			case "edge_520":
				//mLabelX			=	screenCenterX			;
				//mLabelY			=	2						;
				mSpeedValX		=	screenCenterX	-	18	;
				mSpeedValY		=	screenCenterY	+	0	;
				mAvgSpeedValX	=	screenCenterX	+	30	;
				mAvgSpeedValY	=	screenCenterY	-	22	;
				mMaxSpeedValX	=	screenCenterX	+	30	;
				mMaxSpeedValY	=	screenCenterY	+	0	;
				break;
			
			case "edge_1000":		
				//mLabelX			=	screenCenterX			;
				//mLabelY			=	2						;  
				mSpeedValX		=	screenCenterX	-	23	;
				mSpeedValY		=	screenCenterY	+	0	;
				mAvgSpeedValX	=	screenCenterX	+	32	;
				mAvgSpeedValY	=	screenCenterY	-	25	;
				mMaxSpeedValX	=	screenCenterX	+	32	;
				mMaxSpeedValY	=	screenCenterY	+	5	;       		
				break;
		}
		          
        //System.println(model);
          
        View.setLayout(Rez.Layouts.MainLayout(dc));
        //var labelView = View.findDrawableById("label");
        //labelView.locY		=	mLabelY								;
        
        var speedView		=	View.findDrawableById("speed");
        speedView.locX		=	mSpeedValX;
        //speedView.locY		=	mSpeedValY;        
        
        var avgspeedView	=	View.findDrawableById("avgspeed"); 
        avgspeedView.locX	=	mAvgSpeedValX;
        avgspeedView.locY	=	mAvgSpeedValY;
        
        
        var maxspeedView	=	View.findDrawableById("maxspeed");
        maxspeedView.locX	=	mMaxSpeedValX;
        maxspeedView.locY	=	mMaxSpeedValY;
        
        View.findDrawableById("label").setText(Rez.Strings.label);

        return true;
    }

    // The given info object contains all the current workout
    // information. Calculate a value and save it locally in this method.
    function compute(info) {
        // See Activity.Info in the documentation for available information.     
        
        if(info.currentSpeed != null)
        {
        	mSpeedValue		=	info.currentSpeed	*	3.6	;        	
        }
        else
        {
        	mSpeedValue		=	0							;
        }
        
        
        if(info.averageSpeed != null)
        {
        	mAvgSpeedValue	=	info.averageSpeed	*	3.6	;
        }
        else
        {
        	mAvgSpeedValue	=	0							;
        }
        
        if(info.maxSpeed != null)
        {
        	mMaxSpeedValue	=	info.maxSpeed	*	3.6		;
        }
        else
        {
        	mMaxSpeedValue	=	0							;
        }
    }

    // Display the value you computed here. This will be called
    // once a second when the data field is visible.
    function onUpdate(dc) {

		//var info = Activity.getActivityInfo();    
    
    	var mode = Application.getApp().getProperty("mode");
    	if(mode == null)
    	{ mode = 0; }
    	var colorHS = Application.getApp().getProperty("colorHS");
    	if(colorHS == null)
    	{ colorHS = 1; }
    	var colorLS = Application.getApp().getProperty("colorLS");
    	if(colorLS == null)
    	{ colorLS = 0; }
        // Set the foreground color and value
        var speed		=	View.findDrawableById("speed")		;
        var avgspeed	=	View.findDrawableById("avgspeed")	;        
        var maxspeed	=	View.findDrawableById("maxspeed")	;
        
        maxspeed.setColor(Gfx.COLOR_RED);
        if(mode == 1)
        {
        	if(getBackgroundColor() != Gfx.COLOR_BLACK)
        	{
        		speed.setColor(Gfx.COLOR_BLACK);
        		avgspeed.setColor(Gfx.COLOR_BLACK);
            	//maxspeed.setColor(Gfx.COLOR_BLACK);
            	// Set the background color
        		if( mSpeedValue > mAvgSpeedValue)
        		{
        			if(colorHS == 0)
        			{View.findDrawableById("Background").setColor(Gfx.COLOR_RED);}
        			else if(colorHS == 1)
        			{View.findDrawableById("Background").setColor(Gfx.COLOR_GREEN);}
        			else if(colorHS == 2)
        			{View.findDrawableById("Background").setColor(Gfx.COLOR_BLUE);}
        			else if(colorHS == 3)
        			{View.findDrawableById("Background").setColor(Gfx.COLOR_ORANGE);}
        			else if(colorHS == 4)
        			{View.findDrawableById("Background").setColor(Gfx.COLOR_PURPLE);}
        			else if(colorHS == 5)
        			{View.findDrawableById("Background").setColor(Gfx.COLOR_PINK);}
	            }
            	else if( mSpeedValue < mAvgSpeedValue)	
        	    {
    	        	if(colorLS == 0)
        			{View.findDrawableById("Background").setColor(Gfx.COLOR_RED);}
        			else if(colorLS == 1)
        			{View.findDrawableById("Background").setColor(Gfx.COLOR_GREEN);}
        			else if(colorLS == 2)
        			{View.findDrawableById("Background").setColor(Gfx.COLOR_BLUE);}
        			else if(colorLS == 3)
        			{View.findDrawableById("Background").setColor(Gfx.COLOR_ORANGE);}
        			else if(colorLS == 4)
        			{View.findDrawableById("Background").setColor(Gfx.COLOR_PURPLE);}
        			else if(colorLS == 5)
        			{View.findDrawableById("Background").setColor(Gfx.COLOR_PINK);}
	            }
            	else
        	    {
    	    		View.findDrawableById("Background").setColor(getBackgroundColor());
	        	}
        	}
        	else
        	{
        		speed.setColor(Gfx.COLOR_WHITE);
        		avgspeed.setColor(Gfx.COLOR_WHITE);
            	//maxspeed.setColor(Gfx.COLOR_WHITE);
            	// Set the background color
        		if( mSpeedValue > mAvgSpeedValue)
        		{
    	        	if(colorHS == 0)
        			{View.findDrawableById("Background").setColor(Gfx.COLOR_RED);}
        			else if(colorHS == 1)
        			{View.findDrawableById("Background").setColor(Gfx.COLOR_DK_GREEN);}
        			else if(colorHS == 2)
        			{View.findDrawableById("Background").setColor(Gfx.COLOR_BLUE);}
        			else if(colorHS == 3)
        			{View.findDrawableById("Background").setColor(Gfx.COLOR_ORANGE);}
        			else if(colorHS == 4)
        			{View.findDrawableById("Background").setColor(Gfx.COLOR_PURPLE);}
        			else if(colorHS == 5)
        			{View.findDrawableById("Background").setColor(Gfx.COLOR_PINK);}
	            }
            	else if( mSpeedValue < mAvgSpeedValue)	
        	    {
    	        	if(colorLS == 0)
        			{View.findDrawableById("Background").setColor(Gfx.COLOR_RED);}
        			else if(colorLS == 1)
        			{View.findDrawableById("Background").setColor(Gfx.COLOR_DK_GREEN);}
        			else if(colorLS == 2)
        			{View.findDrawableById("Background").setColor(Gfx.COLOR_BLUE);}
        			else if(colorLS == 3)
        			{View.findDrawableById("Background").setColor(Gfx.COLOR_ORANGE);}
        			else if(colorLS == 4)
        			{View.findDrawableById("Background").setColor(Gfx.COLOR_PURPLE);}
        			else if(colorLS == 5)
        			{View.findDrawableById("Background").setColor(Gfx.COLOR_PINK);}
	            }
            	else
        	    {
    	    		View.findDrawableById("Background").setColor(getBackgroundColor());
	        	}
        	}
        	
        }
        else
        {
        	// Set the background color
        	View.findDrawableById("Background").setColor(getBackgroundColor());
        	
	        if(getBackgroundColor() != Gfx.COLOR_BLACK)
    	    {        	
        		if( mSpeedValue > mAvgSpeedValue)
        		{
            		if(colorHS == 0)
        			{speed.setColor(Gfx.COLOR_RED);}
        			else if(colorHS == 1)
        			{speed.setColor(Gfx.COLOR_DK_GREEN);}
        			else if(colorHS == 2)
        			{speed.setColor(Gfx.COLOR_DK_BLUE);}
        			else if(colorHS == 3)
        			{speed.setColor(Gfx.COLOR_ORANGE);}
        			else if(colorHS == 4)
        			{speed.setColor(Gfx.COLOR_PURPLE);}
        			else if(colorHS == 5)
        			{speed.setColor(Gfx.COLOR_PINK);}
	            }
    	        else if( mSpeedValue < mAvgSpeedValue)
        	    {
            		if(colorLS == 0)
        			{speed.setColor(Gfx.COLOR_RED);}
        			else if(colorLS == 1)
        			{speed.setColor(Gfx.COLOR_DK_GREEN);}
        			else if(colorLS == 2)
        			{speed.setColor(Gfx.COLOR_DK_BLUE);}
        			else if(colorLS == 3)
        			{speed.setColor(Gfx.COLOR_ORANGE);}
        			else if(colorLS == 4)
        			{speed.setColor(Gfx.COLOR_PURPLE);}
        			else if(colorLS == 5)
        			{speed.setColor(Gfx.COLOR_PINK);}
	            }
    	        else
        	    {
            		speed.setColor(Gfx.COLOR_BLACK);
	            }
    	        avgspeed.setColor(Gfx.COLOR_BLACK);
        	    //maxspeed.setColor(Gfx.COLOR_BLACK);
	        }
    	    else
        	{            
            	if( mSpeedValue > mAvgSpeedValue)
	        	{
            		if(colorHS == 0)
        			{speed.setColor(Gfx.COLOR_RED);}
        			else if(colorHS == 1)
        			{speed.setColor(Gfx.COLOR_GREEN);}
        			else if(colorHS == 2)
        			{speed.setColor(Gfx.COLOR_BLUE);}
        			else if(colorHS == 3)
        			{speed.setColor(Gfx.COLOR_ORANGE);}
        			else if(colorHS == 4)
        			{speed.setColor(Gfx.COLOR_PURPLE);}
        			else if(colorHS == 5)
        			{speed.setColor(Gfx.COLOR_PINK);}
        	    }
            	else if( mSpeedValue < mAvgSpeedValue)	
	            {
    	        	if(colorLS == 0)
        			{speed.setColor(Gfx.COLOR_RED);}
        			else if(colorLS == 1)
        			{speed.setColor(Gfx.COLOR_GREEN);}
        			else if(colorLS == 2)
        			{speed.setColor(Gfx.COLOR_BLUE);}
        			else if(colorLS == 3)
        			{speed.setColor(Gfx.COLOR_ORANGE);}
        			else if(colorLS == 4)
        			{speed.setColor(Gfx.COLOR_PURPLE);}
        			else if(colorLS == 5)
        			{speed.setColor(Gfx.COLOR_PINK);}
        	    }
            	else
	            {
    	        	speed.setColor(Gfx.COLOR_WHITE);
        	    }
            	avgspeed.setColor(Gfx.COLOR_WHITE);
	            //maxspeed.setColor(Gfx.COLOR_WHITE);
    	    }
        }
       
        speed		.setText		(mSpeedValue.format		("%.1f"))		;
        avgspeed	.setText		(mAvgSpeedValue.format	("%.1f"))		;
        maxspeed	.setText		(mMaxSpeedValue.format	("%.1f"))		;        

        // Call parent's onUpdate(dc) to redraw the layout
        View.onUpdate(dc);
    }
}
