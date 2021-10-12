using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QuanLyThuVien
{
    public partial class FormMain : Form
    {
        public FormMain()
        {
            InitializeComponent();
        }

        private void btnquanlysachIntrangchu_Click(object sender, EventArgs e)
        {
            FormQuanLySach formQuanLySach = new FormQuanLySach();
            formQuanLySach.Show();
            this.Hide();
        }


        private void button2_Click(object sender, EventArgs e)
        {
            FormQLĐGia formQLĐGia = new FormQLĐGia();
            formQLĐGia.Show();
            this.Hide();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            FormQuanLyTraMuonSach formQuanLyTraMuonSach = new FormQuanLyTraMuonSach();
            formQuanLyTraMuonSach.Show();
            this.Hide();
        }
    }
}
