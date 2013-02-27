/*

File: Toyball.m

Abstract: Toyball Exhibit

 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Computer, Inc. ("Apple") in consideration of your agreement to the
 following terms, and your use, installation, modification or
 redistribution of this Apple software constitutes acceptance of these
 terms.  If you do not agree with these terms, please do not use,
 install, modify or redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software. 
 Neither the name, trademarks, service marks or logos of Apple Computer,
 Inc. may be used to endorse or promote products derived from the Apple
 Software without specific prior written permission from Apple.  Except
 as expressly stated in this notice, no other rights or licenses, express
 or implied, are granted by Apple herein, including but not limited to
 any patent rights that may be infringed by your derivative works or by
 other works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.

  Copyright (c) 2004-2006 Apple Computer, Inc., All rights reserved.

*/

#import "Toyball.h"

@implementation Toyball

- (id) init
{
	[super init];
	
	return self;
}

- (void) initLazy
{
	[super initLazy];
	
	/* Setup GLSL */
   {
      NSBundle *bundle;
      NSString *vertex_string, *fragment_string;

      bundle = [NSBundle bundleForClass: [self class]];

		/* Load vertex and fragment shader */
      vertex_string   = [bundle pathForResource: @"Toyball" ofType: @"vert"];
      vertex_string   = [NSString stringWithContentsOfFile: vertex_string];
      fragment_string = [bundle pathForResource: @"Toyball" ofType: @"frag"];
      fragment_string = [NSString stringWithContentsOfFile: fragment_string];
		if ([self loadVertexShader: vertex_string fragmentShader: fragment_string])
			NSLog(@"Failed to load Toyball");
			
		/* Setup uniforms */
		glUseProgramObjectARB(program_object);
		glUniform4fARB(glGetUniformLocationARB(program_object, "LightDir"), 0.57735, 0.57735, 0.57735, 0.0);
		glUniform4fARB(glGetUniformLocationARB(program_object, "BallCenter"), 0.0, 0.0, 0.0, 1.0);
		glUniform4fARB(glGetUniformLocationARB(program_object, "HVector"), 0.32506, 0.32506, 0.88808, 0.0);
		glUniform4fARB(glGetUniformLocationARB(program_object, "SpecularColor"), 0.5, 0.5, 0.4, 60.0);

		glUniform4fARB(glGetUniformLocationARB(program_object, "Red"),    0.6, 0.0, 0.0, 1.0);
		glUniform4fARB(glGetUniformLocationARB(program_object, "Yellow"), 0.6, 0.5, 0.0, 1.0);
		glUniform4fARB(glGetUniformLocationARB(program_object, "Blue"),   0.0, 0.3, 0.6, 1.0);

		glUniform4fARB(glGetUniformLocationARB(program_object, "HalfSpace0"), 1.0, 0.0, 0.0, 0.2);
		glUniform4fARB(glGetUniformLocationARB(program_object, "HalfSpace1"), 0.309016994, 0.951056516, 0.0, 0.2);
		glUniform4fARB(glGetUniformLocationARB(program_object, "HalfSpace2"), -0.809016994, 0.587785252, 0.0, 0.2);
		glUniform4fARB(glGetUniformLocationARB(program_object, "HalfSpace3"), -0.809016994, -0.587785252, 0.0, 0.2);
		glUniform4fARB(glGetUniformLocationARB(program_object, "HalfSpace4"), 0.309016994, -0.951056516, 0.0, 0.2);

		glUniform1fARB(glGetUniformLocationARB(program_object, "InOrOutInit"), -3.0);
		glUniform1fARB(glGetUniformLocationARB(program_object, "StripeWidth"), 0.3);
		glUniform1fARB(glGetUniformLocationARB(program_object, "FWidth"), 0.005);
	}

}

- (void) dealloc
{
	[super dealloc];
}

- (NSString *) name
{
	return @"Toyball";
}

- (NSString *) descriptionFilename
{
	NSBundle *bundle;
	NSString *string;
	bundle = [NSBundle bundleForClass: [self class]];
   string = [bundle pathForResource: @"Toyball" ofType: @"rtf"];
	
	return string;
}

- (void) renderFrame
{
	[super renderFrame];
	
	glUseProgramObjectARB(program_object);

	gluSphere(quadric, 0.5, 30, 30);
	
	glUseProgramObjectARB(NULL);
}

@end