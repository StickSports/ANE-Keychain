package com.sticksports.nativeExtensions.keychain
{
	import flash.external.ExtensionContext;

	public class Keychain
	{
		private static var extensionContext : ExtensionContext;
		
		private static function init() : void
		{
			if ( !extensionContext )
			{
				extensionContext = ExtensionContext.createExtensionContext( "com.sticksports.nativeExtensions.Keychain", null );
			}
		}

		public static function get( key : String ) : String
		{
			init();
			return extensionContext.call( NativeMethods.fetchString, key ) as String;
		}

		public static function insert( key : String, value : String ) : int
		{
			init();
			return extensionContext.call( NativeMethods.insertString, key, value ) as int;
		}

		public static function update( key : String, value : String ) : int
		{
			init();
			return extensionContext.call( NativeMethods.updateString, key, value ) as int;
		}

		public static function insertOrUpdate( key : String, value : String ) : int
		{
			init();
			return extensionContext.call( NativeMethods.insertOrUpdateString, key, value ) as int;
		}

		public static function remove( key : String ) : int
		{
			init();
			return extensionContext.call( NativeMethods.deleteString, key ) as int;
		}
	}
}