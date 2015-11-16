﻿/*
 * This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not
 * distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */
import core.thread;

import std.conv;

import gtk.Main;
import gtk.Version;
import gtk.MessageDialog;

import vg.application;
import vg.constants;

int main(string[] args) {

	//Version checking cribbed from grestful, thanks!
	string error = Version.checkVersion(GTK_VERSION_MAJOR, GTK_VERSION_MINOR, GTK_VERSION_PATCH);
	
	if (error !is null)	{
		Main.init(args);
		
		MessageDialog dialog = new MessageDialog(
			null,
			DialogFlags.MODAL,
			MessageType.ERROR,
			ButtonsType.OK,
			"Your GTK version is too old, you need at least GTK " ~
			to!string(GTK_VERSION_MAJOR) ~ '.' ~
			to!string(GTK_VERSION_MINOR) ~ '.' ~
			to!string(GTK_VERSION_PATCH) ~ '!',
			null
			);
		
		dialog.setDefaultResponse(ResponseType.OK);
		
		dialog.run();
		return 1;
	}


	//Required to initialized send/receive capabilities
	std.concurrency.thisTid;

	auto vgApp = new VisualGrep();
	return vgApp.run(args);
}