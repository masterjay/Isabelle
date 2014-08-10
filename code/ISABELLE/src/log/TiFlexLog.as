package lib.log
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.net.URLVariables;
	
	import lib.AppSetting;
	
	import mx.utils.Base64Encoder;
	
	import util.net.TiHttpRequestHelper;

	public class TiFlexLog
	{
		public static const DEBUG:Number = 1;	
		public static const INFO:Number = 2;	
		public static const WARN:Number = 3;	
		public static const ERROR:Number = 4;	
		public static const FATAL:Number = 5;	
		
		private static var m_Base64Encoder:Base64Encoder = new Base64Encoder();
		
		public function TiFlexLog()
		{
			
		}
		static public function fnSendLog(strMessage:String,nLevel:Number = 1):void
		{
			if(nLevel >= AppSetting.m_LogLevel)
			{
				var time:Date = new Date();
				strMessage = time.toString() + " " + strMessage
				var httpHelper:TiHttpRequestHelper = new TiHttpRequestHelper();
				
				httpHelper.addEventListener( Event.COMPLETE, fnSendComplete );
				httpHelper.addEventListener( ErrorEvent.ERROR, fnSendError );
				var httpVars:URLVariables = new URLVariables();
				httpVars.messageType = nLevel.toString();
				trace("fnSendLog:"+strMessage)
				m_Base64Encoder.encodeUTFBytes( strMessage );
				httpVars.message = m_Base64Encoder.toString();		
				httpHelper.fnSendRequest(AppSetting.LOG_SERVICE, httpVars);
			}
			if(AppSetting.m_bDebug)
			{
				fnMakeTraceMsg(strMessage,nLevel);
				if(nLevel>=FATAL)
				{
					throw(strMessage)
				}
			}
		}
		static private function fnSendComplete(e:Event):void
		{
			
		}
		static private function fnSendError(e:Event):void
		{
			
		}
		static private function fnMakeTraceMsg(strMessage:String,nLevel:Number = 1):void
		{
			var strLevel:String = "";
			switch(nLevel)
			{
				case DEBUG:
					strLevel = "DEBUG:";
					break;
				case INFO:
					strLevel = "INFO:";
					break;
				case WARN:
					strLevel = "WARN:";
					break;
				case ERROR:
					strLevel = "ERROR:";
					break;
				case FATAL:
					strLevel = "FATAL:";
					break;
			}
			trace("##TiFlexLog:"+strLevel+strMessage)
		}
	}
}