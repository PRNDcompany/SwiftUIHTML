//  Copyright © 2025 PRND. All rights reserved.

import SwiftUI
import SwiftUIHTML

struct BoxModelSample: View {
    let html = """
        <h2>CSS Box Model</h2>
        
        <div style="background-color: #FFE0B2; padding: 20px;">
            <p>Box with 20px padding applied</p>
        </div>
        
        <div style="background-color: #C8E6C9; padding: 10px 20px;">
            <p>Top-bottom 10px, left-right 20px padding</p>
        </div>
        
        <div style="background-color: #B3E5FC; padding: 5px 10px 15px 20px;">
            <p>Top 5px, right 10px, bottom 15px, left 20px padding</p>
        </div>
        
        <h2>Margin</h2>
        
        <div style="background-color: #F8BBD0; margin: 20px; padding: 10px;">
            <p>20px margin on all sides</p>
        </div>
        
        <div style="background-color: #E1BEE7; margin: 10px 30px; padding: 10px;">
            <p>Top-bottom 10px, left-right 30px margin</p>
        </div>
        
        <h2>Border</h2>
        
        <div style="border: 1px solid #333; padding: 10px; margin: 10px;">
            <p>1px solid border</p>
        </div>
        
        <div style="border: 2px solid #2196F3; padding: 10px; margin: 10px;">
            <p>2px blue border</p>
        </div>
        
        <div style="border: 3px solid #4CAF50; border-radius: 8px; padding: 10px; margin: 10px;">
            <p>3px green border + rounded corners</p>
        </div>
        
        <h2>Complex Example</h2>
        
        <div style="margin: 20px; padding: 20px; border: 2px solid #FF5722; border-radius: 12px; background-color: #FFF3E0;">
            <h3 style="margin-top: 0; color: #FF5722;">Box Model Complete</h3>
            <p style="margin-bottom: 0;">
                A box with margin, padding, and border all applied.
                Internal content has spacing equal to padding,
                and is separated from outside by margin distance.
            </p>
        </div>
        
        <div style="background-color: #E8F5E9; padding: 16px; margin: 16px 0;">
            <div style="background-color: white; padding: 12px; margin-bottom: 8px; border: 1px solid #C8E6C9;">
                <p style="margin: 0;">Nested box 1</p>
            </div>
            <div style="background-color: white; padding: 12px; border: 1px solid #C8E6C9;">
                <p style="margin: 0;">Nested box 2</p>
            </div>
        </div>
        """
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Title
                VStack(alignment: .leading, spacing: 8) {
                    Text("Box Model")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("CSS Box Model: padding, margin, border")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Divider()
                
                // HTML rendering
                HTMLView(html: html, parser: HTMLFuziParser())
                    .htmlEnvironment(\.configuration, .sample)
                    .htmlEnvironment(\.styleContainer, .sample(by: .byWordWrapping))
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                // Box model structure
                VStack(alignment: .leading, spacing: 8) {
                    Text("CSS Box Model Structure")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("• Content: Actual content area")
                        Text("• Padding: Internal spacing between content and border")
                        Text("• Border: Element's border")
                        Text("• Margin: External spacing between elements")
                    }
                    .font(.body)
                }
                
                // Padding syntax
                VStack(alignment: .leading, spacing: 8) {
                    Text("Padding Syntax")
                        .font(.headline)
                    
                    Text("""
/* Same value for all directions */
padding: 20px;

/* Top-bottom, left-right */
padding: 10px 20px;

/* Top, left-right, bottom */
padding: 10px 15px 20px;

/* Top, right, bottom, left (clockwise) */
padding: 5px 10px 15px 20px;
""")
                    .font(.system(.body, design: .monospaced))
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
                
                // Margin syntax
                VStack(alignment: .leading, spacing: 8) {
                    Text("Margin Syntax")
                        .font(.headline)
                    
                    Text("Uses the same syntax as padding.")
                        .font(.body)
                    
                    Text("""
margin: 20px;              /* All directions */
margin: 10px 30px;         /* Top-bottom, left-right */
margin: 10px 20px 30px;    /* Top, left-right, bottom */
margin: 5px 10px 15px 20px; /* Top, right, bottom, left */
""")
                    .font(.system(.body, design: .monospaced))
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
                
                // Border syntax
                VStack(alignment: .leading, spacing: 8) {
                    Text("Border Syntax")
                        .font(.headline)
                    
                    Text("""
/* Basic border */
border: 1px solid black;

/* Color specification */
border: 2px solid #2196F3;

/* Rounded corners */
border-radius: 8px;
border-radius: 4px 8px 12px 16px;
""")
                    .font(.system(.body, design: .monospaced))
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
                
                // Practical tips
                VStack(alignment: .leading, spacing: 8) {
                    Text("Box Model Usage Tips")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("• Padding: Expand click area, improve readability")
                        Text("• Margin: Element spacing, layout composition")
                        Text("• Border: Visual separation, emphasis effects")
                        Text("• Combination: Card UI, buttons, notification boxes, etc.")
                    }
                    .font(.body)
                    .foregroundColor(.secondary)
                }
            }
            .padding()
        }
        .navigationTitle("Box Model")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        BoxModelSample()
    }
}