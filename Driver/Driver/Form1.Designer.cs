namespace Driver
{
    partial class MainForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.btnStand = new System.Windows.Forms.Button();
            this.btnOff = new System.Windows.Forms.Button();
            this.btnLeftFrontUp = new System.Windows.Forms.Button();
            this.btnRightFrontUp = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // btnStand
            // 
            this.btnStand.Location = new System.Drawing.Point(278, 42);
            this.btnStand.Name = "btnStand";
            this.btnStand.Size = new System.Drawing.Size(112, 23);
            this.btnStand.TabIndex = 0;
            this.btnStand.Text = "Stand";
            this.btnStand.UseVisualStyleBackColor = true;
            this.btnStand.Click += new System.EventHandler(this.btnStand_Click);
            // 
            // btnOff
            // 
            this.btnOff.Location = new System.Drawing.Point(278, 13);
            this.btnOff.Name = "btnOff";
            this.btnOff.Size = new System.Drawing.Size(112, 23);
            this.btnOff.TabIndex = 1;
            this.btnOff.Text = "OFF";
            this.btnOff.UseVisualStyleBackColor = true;
            this.btnOff.Click += new System.EventHandler(this.btnOff_Click);
            // 
            // btnLeftFrontUp
            // 
            this.btnLeftFrontUp.Location = new System.Drawing.Point(278, 72);
            this.btnLeftFrontUp.Name = "btnLeftFrontUp";
            this.btnLeftFrontUp.Size = new System.Drawing.Size(112, 23);
            this.btnLeftFrontUp.TabIndex = 2;
            this.btnLeftFrontUp.Text = "LeftFront UP";
            this.btnLeftFrontUp.UseVisualStyleBackColor = true;
            this.btnLeftFrontUp.Click += new System.EventHandler(this.btnLeftFrontUp_Click);
            // 
            // btnRightFrontUp
            // 
            this.btnRightFrontUp.Location = new System.Drawing.Point(278, 101);
            this.btnRightFrontUp.Name = "btnRightFrontUp";
            this.btnRightFrontUp.Size = new System.Drawing.Size(112, 23);
            this.btnRightFrontUp.TabIndex = 3;
            this.btnRightFrontUp.Text = "Right Front UP";
            this.btnRightFrontUp.UseVisualStyleBackColor = true;
            this.btnRightFrontUp.Click += new System.EventHandler(this.btnRightFrontUp_Click);
            // 
            // MainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(411, 408);
            this.Controls.Add(this.btnRightFrontUp);
            this.Controls.Add(this.btnLeftFrontUp);
            this.Controls.Add(this.btnOff);
            this.Controls.Add(this.btnStand);
            this.Name = "MainForm";
            this.Text = "Form1";
            this.Load += new System.EventHandler(this.MainForm_Load);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button btnStand;
        private System.Windows.Forms.Button btnOff;
        private System.Windows.Forms.Button btnLeftFrontUp;
        private System.Windows.Forms.Button btnRightFrontUp;
    }
}

