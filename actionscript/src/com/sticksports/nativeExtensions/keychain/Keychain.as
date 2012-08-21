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

		public static function get( key : String, accessGroup : String = null ) : String
		{
			init();
			if( accessGroup )
			{
				return extensionContext.call( NativeMethods.fetchString, key, accessGroup ) as String;
			}
			else
			{
				return extensionContext.call( NativeMethods.fetchString, key ) as String;
			}
		}

		public static function insert( key : String, value : String, accessGroup : String = null ) : int
		{
			init();
			if( accessGroup )
			{
				return extensionContext.call( NativeMethods.insertString, key, value, accessGroup ) as int;
			}
			else
			{
				return extensionContext.call( NativeMethods.insertString, key, value ) as int;
			}
		}

		public static function update( key : String, value : String, accessGroup : String = null ) : int
		{
			init();
			if( accessGroup )
			{
				return extensionContext.call( NativeMethods.updateString, key, value, accessGroup ) as int;
			}
			else
			{
				return extensionContext.call( NativeMethods.updateString, key, value ) as int;
			}
		}

		public static function insertOrUpdate( key : String, value : String, accessGroup : String = null ) : int
		{
			init();
			if( accessGroup )
			{
				return extensionContext.call( NativeMethods.insertOrUpdateString, key, value, accessGroup ) as int;
			}
			else
			{
				return extensionContext.call( NativeMethods.insertOrUpdateString, key, value ) as int;
			}
		}

		public static function remove( key : String, accessGroup : String = null ) : int
		{
			init();
			if( accessGroup )
			{
				return extensionContext.call( NativeMethods.deleteString, key, accessGroup ) as int;
			}
			else
			{
				return extensionContext.call( NativeMethods.deleteString, key ) as int;
			}
		}
	}
}