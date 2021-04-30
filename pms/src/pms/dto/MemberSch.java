package pms.dto;
// pms.dto.MemberSch
public class MemberSch {
	// 1. 검색 속성
	private String name; // 이름 검색
	private String part;
	private int pno;
	// 2. 페이징 처리
	private int count; // 총데이터 건수
	private int pageSize; // 한 페이지에서 보여줄 데이터 건수  pageSize curPage
	private int pageCount; // 총 페이지 수 (count/pageSize)
	private int curPage; // 현재 페이지
	private int start; // 페이지의 시작 번호
	private int end; // 페이지의 끝 번호
	// 3. block 처리
	private int blockSize; // 한 번에 보여줄 block의 크기
	private int startBlock; // block의 시작 번호
	public int getBlockSize() {
		return blockSize;
	}
	public void setBlockSize(int blockSize) {
		this.blockSize = blockSize;
	}
	private int endBlock; // block의 마지막 번호
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public String getPart() {
		return part;
	}
	public void setPart(String part) {
		this.part = part;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getPageCount() {
		return pageCount;
	}
	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}
	public int getCurPage() {
		return curPage;
	}
	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public int getEnd() {
		return end;
	}
	public void setEnd(int end) {
		this.end = end;
	}
	public int getStartBlock() {
		return startBlock;
	}
	public void setStartBlock(int startBlock) {
		this.startBlock = startBlock;
	}
	public int getEndBlock() {
		return endBlock;
	}
	public void setEndBlock(int endBlock) {
		this.endBlock = endBlock;
	}
	public int getPno() {
		return pno;
	}
	public void setPno(int pno) {
		this.pno = pno;
	}
	
}


