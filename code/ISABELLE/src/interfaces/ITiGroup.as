package interfaces
{
	import lib.Customer;

	public interface ITiGroup
	{
		function fnSwfResize():void
		function fnAddNewCustomerToServer(c:Customer):void
		function fnReady():void
	}
}