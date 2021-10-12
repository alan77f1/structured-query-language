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
    public partial class FormQLĐGia : Form
    {
        public FormQLĐGia()
        {
            InitializeComponent();
        }

        private void btnQuanLySach_Click(object sender, EventArgs e)
        {
            FormQuanLySach formQuanLySach = new FormQuanLySach();
            formQuanLySach.Show();
            this.Hide();
        }

        private void btnTrangChuInQLS_Click(object sender, EventArgs e)
        {
            FormMain formTrang = new FormMain();
            formTrang.Show();
            this.Hide();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            FormQuanLyTraMuonSach formQuanLyTraMuonSach = new FormQuanLyTraMuonSach();
            formQuanLyTraMuonSach.Show();
            this.Hide();
        }

        private void panel1_Paint(object sender, PaintEventArgs e)
        {

        }
    }
}
