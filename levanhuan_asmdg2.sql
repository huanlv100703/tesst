-- YC6
-- - 6.1 : Liệt kê tất cả thông tin của các đầu sách gồm tên sách, mã sách, giá tiền , tác giả thuộc loại sách 'Công nghệ thông tin'
select tenSach, maSach, giaTien, tacGia 
from sach sa
inner join loaisach ls on ls.maLoaiSach = sa.maLoaiSach
where ls.maLoaiSach = '2';

-- - 6.2: Liệt kê các phiếu mượn gồm các thông tin mã phiếu mượn, mã sách , ngày mượn, mã sinh viên có ngày mượn trong tháng 01/2017.
select maPhieuMuon, maSach,ngayMuon,maSinhVien
from phieumuon
where month(ngayMuon) = 1 and year(ngayMuon) = 2017;

-- - 6.3: Liệt kê các phiếu mượn chưa trả sách cho thư viên theo thứ tự tăng dần của ngày mượn sách.
select *
from phieumuon
where trangThai = 'Chưa trả'
order by ngayMuon asc;

-- - 6.4: Liệt kê tổng số đầu sách của mỗi loại sách ( gồm mã loại sách, tên loại sách, tổng số lượng sách mỗi loại).
select ls.maLoaiSach, ls.loaiSach, count(sa.maLoaiSach) as tongSoLuongSachMoiLoai
from loaisach ls
inner join sach sa on sa.maLoaiSach = ls.maLoaiSach
group by ls.maLoaiSach;

-- - 6.5: Đếm xem có bao nhiêu lượt sinh viên đã mượn sách
select count(DISTINCT maSinhVien) as soSinhVienMuonSach
from phieumuon;

-- - 6.6: Hiển thị tất cả các quyển sách có tiêu đề chứa từ khoá “SQL”.
select *
from sach
where tenSach like 'SQL';
-- - 6.7: Hiển thị thông tin mượn sách gồm các thông tin: mã sinh viên, tên sinh viên, mã phiếu mượn, tiêu đề sách, ngày mượn, ngày trả. Sắp xếp thứ tự theo ngày mượn sách.
select sv.maSinhVien, sv.tenSinhVien, pm.maPhieuMuon, sa.tenSach, pm.ngayMuon, pm.ngayTra
from phieumuon pm
inner join sach sa on sa.maSach = pm.maSach
inner join sinhvien sv on sv.maSinhVien = pm.maSinhVien
order by pm.ngayMuon asc;

-- - 6.8 Liệt kê các đầu sách có lượt mượn lớn hơn hoặc bằng 2 lần.
select maSach , count(maSach) as luotMuon
from phieumuon
group by maSach
having count(maSach) > 2;
 -- - 6.9: Viết câu lệnh cập nhật lại giá tiền của các quyển sách có ngày nhập kho trước năm 2014 giảm 30%.
update sach
set giaTien = giaTien * 0.7
where year(ngayNhapKho) < '2014';

-- - 6.10:  Viết câu lệnh cập nhật lại trạng thái đã trả sách cho phiếu mượn của sinh viên có mã sinh viên PD12301 (ví dụ).
 update phieumuon
 set trangThai = 'Đã trả'
 where maSinhVien = '1';

-- - 6.11:  Lập danh sách các phiếu mượn quá hạn chưa trả gồm các thông tin: mã phiếu mượn, tên sinh viên, email, danh sách các sách đã mượn, ngày mượn
select pm.maPhieuMuon, sv.tenSinhVien, sv.email, sa.tenSach, pm.ngayMuon
from sinhvien sv
inner join phieumuon pm on pm.maSinhVien = sv.maSinhVien
inner join sach sa on sa.maSach = pm.maSach
where day(pm.ngayTra) - day(ngayMuon) > 7; 

-- - 6.12: Viết câu lệnh cập nhật lại số lượng bản sao tăng lên 5 đơn vị đối với các đầu sách có lượt mượn lớn hơn 2
update sach
set soLuongBanSao = soLuongBanSao + 5
where maSach in (select maSach 
				from phieumuon 
                group by maSach
                having count(maSach)>2);

-- - 6.13: Viết câu lệnh xoá các phiếu mượn có ngày mượn và ngày trả trước „1/1/2017‟
delete
from phieumuon
where year(ngayTra) < 2017
and month(ngayTra) < 1
and day(ngayTra)<1;









